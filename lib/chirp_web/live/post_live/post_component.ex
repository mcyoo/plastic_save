defmodule ChirpWeb.PostLive.PostComponent do
  use ChirpWeb, :live_component


  def render(assigns) do
    ~L"""
    <div id="post-<%= @post.id %>" class="post w-screen h-screen flex items-center justify-center font-sans font-bold">
      <div class="flex flex-col items-center justify-center text-center">
        <div class="text-lg">
          우리가 줄인 일회용컵 (실시간)
        </div>
        <div class="flex text-6xl m-4">
          <div>
            <img class="w-16 animate-waving" src="/images/plasticCup.png" />
          </div>
          <a class="animate-bounce" href="#" phx-click="like" phx-target="<%= @myself %>">
            <%= @post.likes_count %>
          </a>
        </div>
        <div class="mt-6 text-lg">
          탄소 절감
        </div>
        <div class="flex text-3xl m-4 items-center">
          <div>
            <img class="w-14 mr-2 animate-waving" src="/images/carbon.png" />
          </div>
          <div>
            <%= carbon(@post.likes_count) %> kg
          </div>
        </div>
        <div class="mt-6 text-lg">
          나무 심기
        </div>
        <div class="flex text-2xl m-4 items-center">
          <div>
            <img class="w-14 mr-2 animate-waving" src="/images/tree.png" />
          </div>
          <span class="text-3xl mr-2"><%= tree(@post.likes_count) %></span> 그루
        </div>
      </div>
    </div>
    """
  end

  def carbon(likes_count) do
    likes_count * 49 / 1000
  end

  def tree(likes_count) do
    round(likes_count * 49 / 1000 / 8)
  end

  def handle_event("like", parms, socket) do
    Chirp.Timeline.inc_likes(socket.assigns.post)

    {:noreply, assign(socket, class: 'animate-bounce')}
  end

  def handle_event("repost", _, socket) do
    Chirp.Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end
end
