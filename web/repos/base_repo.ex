defmodule Octograph.BaseRepo do

  defmacro __using__(_opts) do
    quote do
      import Ecto.Query
      alias Octograph.Repo

      def create(models) when is_list(models) do
        Enum.map(models, fn(model) -> create(model) end)
      end

      def create(model) do
        try do
          Repo.insert(model)
        rescue
          error in Postgrex.Error ->
            if error.postgres.code == :unique_violation do
              {false, :unique_violation}
            else
              raise error
            end  
        end
      end

      def update(model), do: Repo.update(model)

      def delete_all do
        query = from un in module
        Octograph.Repo.delete_all(query)
      end

      def count do
        query = from(un in module, select: count(un.id))
        Octograph.Repo.one(query)
      end

      def find_by_ids(ids) do
        query = from r in module, where: r.id in ^ids, select: r
        Octograph.Repo.all(query)
      end

      def find(id), do: Repo.get(module, id)
      
      def all(), do: Repo.all(from m in module, select: m)
      def all(query), do: Repo.all(query)

      def first do
        query = from(m in module, order_by: [asc: m.id], limit: 1)
        Octograph.Repo.one(query)
      end

      def last do
        query = from(m in module, order_by: [desc: m.id], limit: 1)
        Octograph.Repo.one(query)
      end


      defp module() do
        Atom.to_string(__MODULE__) |> String.split("Repo")
        |> List.first |> String.to_atom
      end

    end
  end

end