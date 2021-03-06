describe "Quickbooks::Service::ItemChange" do
  before(:all) do
    construct_service :item_change
  end

  it "can query for items" do
    xml = fixture("item_changes.xml")
    model = Quickbooks::Model::ItemChange

    stub_request(:get, @service.url_for_query, ["200", "OK"], xml)
    items = @service.query
    items.entries.count.should == 1

    first_item = items.entries.first
    first_item.status.should == 'Deleted'
    first_item.id.should == "39"

    first_item.meta_data.should_not be_nil
    first_item.meta_data.last_updated_time.should == DateTime.parse("2014-12-08T19:36:24-08:00")
  end

end
