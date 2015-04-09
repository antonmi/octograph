defmodule Octograph.BaseRepo do

	defmacro __using__(_opts) do
    quote do

     	def db do
     		mongo_db = Application.get_env(:octograph, :mongo_db)
     	 	Mongo.connect!("127.0.0.1", 27017) |> Mongo.db(mongo_db)
     	end

    end
  end    

end