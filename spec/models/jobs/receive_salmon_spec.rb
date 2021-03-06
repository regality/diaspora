require 'spec_helper'

describe Jobs::ReceiveSalmon do
  before do
    @user = alice
    @xml = '<xml></xml>'
    User.stub(:find){ |id|
      if id == @user.id
        @user
      else
        nil
      end
    }
  end
  it 'calls receive_salmon' do
    zord = mock

    zord.should_receive(:perform)
    Postzord::Receiver::Private.should_receive(:new).with(@user, hash_including(:salmon_xml => @xml)).and_return(zord)

    Jobs::ReceiveSalmon.perform(@user.id, @xml)
  end
end
