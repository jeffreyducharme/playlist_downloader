module WebdriverHelper

	def no_extra_tabs(browser, url)
		until browser.windows.size == 1 do
			browser.windows.last.close
		end
		unless browser.window.url.include? url 
			browser.goto(url)
		end
	end	

end