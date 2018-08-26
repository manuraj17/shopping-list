defmodule ShoppingList do
  use GenServer

  #
  # CLIENT API
  #

  # The first function you will need to implement is for starting the server
  # Arguments:
  #   first: Location where the server callbacks are implemented.
  #     - Here it's the same file hence the same __MODULE__. Ofcourse this can
  #       be split between client and server modules.
  #   second: Initialisation arguments for the module.
  #     - Here there is no specific arguments hence the atom :ok
  #   third: List of options that can be used to set certain values.
  #     - Here ther is no specific values hence empty set.
  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  # Public APIs for the module - these are functions that will be invoked by
  # other modules of the application.
  # Here we declared two functions - one for adding items to the shopping list
  # and one for reading items from the shopping list.
  #
  # read/1 accepts the pid and we make use of call method from GenServer to talk
  # to the process.
  #
  # NOTE: GenServer.call/2 is blocking.
  #
  # add/2 takes the pid and the item to be added to the shopping list. We make
  # use of GenServer cast/2 to talk to the process. This function returns
  # immediately as it does not wait for response.
  #
  # NOTE: GenServer.cast/2 function is non blocking.
  #
  # NOTE: The downside of cast/2 being non blocking is that you will not be able
  # to know if the addition was successful or not.
  def read(pid) do
    GenServer.call(pid, { :read })
  end

  def add(pid, item) do
    GenServer.cast(pid, { :add, item })
  end


  #
  # SERVER Callbacks
  #

  # `init` is automatically called when the process is started via the
  # `start_link  function. Here you can see that the only arguments to `init`
  # function are the arguments that are passed as the second arguments for the
  # `start_link` function.
  #
  # Whatever is required to start the server can be done here. The return value
  # of this function should be a tuple where the first item is atom :ok and the
  # second item the initial state of the server.
  def init(:ok) do
    { :ok, [] }
  end

  # Handling incoming requests from public API.
  #
  # Handling read.
  # We implement handle_call/3 and use pattern matching to handle the specific
  # request.
  # Second argument to `handle_call` is the pid of the process that send the
  # request.
  # Third argument is the current state of the process.
  #
  # The return value of `handle_call/3` should be a tuple where the first value
  # is atom `:reply` and second value is the value that needs to be returned to
  # the client.
  def handle_call({:read}, _from, list) do
    { :reply, list, list }
  end

  # Handling cast.
  # We implement `handle_cast/2` and again using pattern matching.
  # Here we don't have pid of the requesting process because we are not gong to
  # send back any reply.
  # The return value of this function should be a tupe where the first value is
  # atom `:noreply` and second value is the state.
  def handle_cast({:add, item}, list) do
    { :noreply, list ++ [item] }
  end
end
