defmodule TicketMetricsTest do
  use ExUnit.Case
  use Zendesk
  use TestHelper
  use ExVCR.Mock


  test "it gets all ticket metrics" do
    use_cassette "all_metrics" do
      res = Zendesk.account(subdomain: "your_subdomain",
      email: "test@test.com", password: "test")
      |> all_metrics

      assert length(res) == 100
      assert res |> hd |> Dict.get(:id) == 2738394508
    end
  end

  test "it gets metrics for ticket" do
    use_cassette "metrics_for_ticket" do
      res = Zendesk.account(subdomain: "your_subdomain",
      email: "test@test.com", password: "test")
      |> metrics_for_ticket(ticket_id: "603")

      assert res.id == 2738394508
      assert res.replies == 0
    end
  end

  test "it gets metrics for id" do
    use_cassette "metrics_with_id" do
      res = Zendesk.account(subdomain: "your_subdomain",
      email: "test@test.com", password: "test")
      |> metrics_with_id(id: "2738394508")

      assert res.id == 2738394508
      assert res.replies == 0
    end
  end

end
