defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    IO.puts("Mount #{inspect(self())}")
    socket = assign(socket, :brightness, 10)
    IO.inspect(socket)
    {:ok, socket}
  end

  def render(assigns) do
    IO.puts("Render #{inspect(self())}")

    ~L"""
      <h1>Front Porch Light</h1>
      <div id="light">
        <div class="meter">
          <span style="width: <%= @brightness %>%">
          <%= @brightness %>
          </span>
        </div>

        <button phx-click="off">
          <img src="images/light-off.svg"/>
        </button>

        <button phx-click="down">
          <img src="images/down.svg"/>
        </button>

        <button phx-click="up">
          <img src="images/up.svg"/>
        </button>

        <button phx-click="on">
          <img src="images/light-on.svg"/>
        </button>

        <button phx-click="light-me-up">
          Light Me Up!
        </button>


      </div>
    """
  end

  def handle_event("on", _, socket) do
    IO.puts("ON #{inspect(self())}")

    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    IO.puts("OFF #{inspect(self())}")

    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end

  def handle_event("down", _, socket) do
    socket = update(socket, :brightness, &max(&1 - 10, 0))
    {:noreply, socket}
  end

  def handle_event("up", _, socket) do
    socket = update(socket, :brightness, &min(&1 + 10, 100))
    {:noreply, socket}
  end

  def handle_event("light-me-up", _, socket) do
    ran = :rand.uniform(100)
    socket = assign(socket, :brightness, ran)
    {:noreply, socket}
  end
end
