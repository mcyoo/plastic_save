defmodule ChirpWeb.PostLive.PostComponent do
  use ChirpWeb, :live_component


  def render(assigns) do
    ~L"""
    <div id="post-<%= @post.id %>" class="post">
    <div class="text-xl text-center mb-12 font-pruncup">
      우리가 줄인 쓰레기 현황
    </div>
      <div class="flex flex-col items-center justify-center text-center">
        <div class="flex">
          <div>
            <div class="text-lg font-pruncup">
              일회용 컵<span class="text-sm">(42g)</span>
            </div>
            <div class="flex text-5xl m-4">
              <div>
                <img class="w-16 animate-waving" src="/images/plasticCup.png" />
              </div>
              <a class="animate-bounce mt-2 font-ants" href="#" phx-click="like" phx-target="<%= @myself %>">
                <%= @post.likes_count %>
              </a>
            </div>
          </div>
          <div>
            <div class="text-lg font-pruncup">
            비닐 봉지<span class="text-sm">(10g)</span>
            </div>
            <div class="flex text-5xl m-4">
              <div>
                <img class="w-14 animate-waving mr-3" src="/images/plastic_bag.png" />
              </div>
                <a class="animate-bounce mt-2 font-ants" href="#" phx-click="repost" phx-target="<%= @myself %>">
                  <%= @post.reposts_count %>
                </a>
            </div>
          </div>
        </div>
        <div class="mt-6 text-lg font-pruncup">
          탄소 절감
        </div>
        <div class="flex text-2xl m-4 items-center">
          <div>
            <img class="w-14 mr-2 animate-waving" src="/images/carbon.png" />
          </div>
          <span class="text-3xl font-ants"><%= carbon(@post.likes_count, @post.reposts_count) %> kg </span>
        </div>
        <div class="mt-6 text-lg font-pruncup">
          나무 심기
        </div>
        <div class="flex text-2xl m-4 items-center">
          <div>
            <img class="w-14 mr-2 animate-waving" src="/images/tree.png" />
          </div>
          <span class="text-3xl mr-2 font-ants"><%= tree(@post.likes_count, @post.reposts_count) %> 그루 </span>
        </div>
      </div>
    </div>
    """
  end

  def carbon(likes_count,reposts_count) do
    Float.floor((likes_count * 49 / 1000) + (reposts_count * 10 / 1000),2)
  end

  def tree(likes_count,reposts_count) do
    round(carbon(likes_count,reposts_count) / 8)
  end

  def handle_event("like", _, socket) do
    Chirp.Timeline.inc_likes(socket.assigns.post)

    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    Chirp.Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end
end
