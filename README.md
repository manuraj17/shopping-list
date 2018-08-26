# GenServer example

### GenServer
Specification for writing generic server process in Elixir. Simply a module
that provides default implementations for `:gen_server` Erlang behavior.

### Sample output
```
❯ iex shopping_list.exs                                                                                                                                                               genserver/git/master
Erlang/OTP 21 [erts-10.0.3] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe] [dtrace]

Interactive Elixir (1.6.6) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> {:ok, pid} = ShoppingList.start_link
{:ok, #PID<0.105.0>}
iex(2)> ShoppingList.add(pid, "milk")
:ok
iex(3)> ShoppingList.add(pid, "bread")
:ok
iex(4)> ShoppingList.add(pid, "cheese")
:ok
iex(5)> ShoppingList.read(pid)
["milk", "bread", "cheese"]
```
