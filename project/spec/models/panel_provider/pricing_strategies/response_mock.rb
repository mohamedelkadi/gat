# Helpers
def mock_response
  remote_inst = RemotePage.new('http://test.com')

  expect(RemotePage).to receive(:new).and_return(remote_inst)
  expect(remote_inst).to receive(:fetch).and_return(web_response)
end