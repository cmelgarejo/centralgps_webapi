defmodule CentralGPS.Repo.Utilities do
  alias Enum,   as: E
  alias String, as: S
  alias Tuple,  as: T
  @doc """
  Pretty prints any error you pass on to this func.

  ex  : exception object
  _env: __ENV__ object of the function
  vars: a map with all the vars you want to control. i.e: %{var1: var1}
  """
  def error_logger(ex, _env, vars \\ []) do
    require Logger
    env = Macro.Env.stacktrace(_env) |> hd
    Logger.error "[#{env |> elem 0}.#{env |> elem 1}]: #{inspect ex}
    file: #{env |> elem(3) |> hd |> elem (1)}
    line: #{env |> elem(3) |> tl |> hd |> elem(1)}
    vars: #{inspect vars}"
  end

  @doc """
  Makes any map that doesn't have atoms as keys to an atomized map, syntax sugar
  for OOProgramers :P

  Parameters:

  map:  The map that should be proccesed.

  filter_keys: (optional) keys that will filter the map and leave only those
  that match, in case ANY of the keys it's not in the processed map,
  the function will return [ArgumentError]

  """
  def objectify_map(map, filter_keys \\ []) do
    try do
      if !(E.empty?filter_keys) do
        (for k <- filter_keys, !Map.has_key?(map,k), do:
          (raise ArgumentError, message: "missing: #{k}"))
        map = Map.take map, filter_keys
      end
      E.map(map,fn({k,v})->{(if !is_atom(k), do: S.to_atom(k), else: k),v}end)
      |> E.into %{}
    rescue
      e in _ ->
        error_logger e, __ENV__, %{map: map, filter_keys: filter_keys}
        raise e
    end
  end

  @doc """
  Validates and decodes a Base64 encoded string
  """
  def base64_decode(b64str) do
    try do
      case b64str do
        nil -> nil
        _   ->
          case Base.url_decode64(b64str) do
            {:ok, str} -> if (S.valid?str), do: str
            _          -> nil
          end
      end
    rescue
      e in _ ->
        error_logger e, __ENV__, %{b64str: b64str}
        raise e
    end
  end

  @doc """
  Encodes a string to Base64
  """
  def base64_encode(str) do
    try do
      if (S.valid?str), do: (Base.url_encode64 str), else: str
    rescue
      e in _ ->
        error_logger e, __ENV__, %{str: str}
        raise e
    end
  end

  @doc """
  Converts a result from Ecto.Adapters.SQL.query to a map %{} (JSON parseable)

  table: A Ecto table result (map) from Ecto.Adapters.SQL.query i.e:
  %{columns: ["col1", "col2", "col3"], command: :select, num_rows: 1,
    rows: [{1, "value1", nil}]}

  filter:  Contains a list of keys that should be used and taken if present
  (exclusively)
  """
  def table_to_map(table, filter \\ []) do
    try do
      if table.num_rows > 0 do
        result = (for r <- table.rows, do:
              E.zip((table.columns |> E.map &(S.to_atom &1)),T.to_list(r))
           |> E.into(%{}))
        {row_count, result} =
        {
          table.num_rows,
          result = (if (!E.empty?filter), do:
                      (for m <- result, do: Map.take(m, filter)), else: result)
        }
      else
        { 0, [] }
      end
    rescue
      e in _ ->
        error_logger e, __ENV__, %{table: table}
        raise e
    end
  end

end