require 'spec_helper'

describe 'Index Dialpeer', type: :feature do
  include_context :login_as_admin

  include_examples :test_index_table_exist do
    before do
      @item = create(:dialpeer)
      visit dialpeers_path
    end
  end
end
