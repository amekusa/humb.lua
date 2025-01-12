----- HUMmingBird -----
-- github.com/amekusa

local NS = (...)

local M = {}
function M.new_test(...)
	local humb = {}

	function humb:init(opts)
		if type(opts) == 'number' then
			opts = {rpt = opts}
		end
		self.cases = {}
		self.logs = {}
		self.rpt = opts.rpt or 1
		self.now = opts.now or os.clock
	end

	function humb:log(msg)
		table.insert(self.logs, msg)
	end

	function humb:print(fn)
		if type(fn) ~= 'function' then
			fn = print
		end
		fn(table.concat(self.logs, '\n'))
	end

	function humb:case(name, fn)
		local case = {
			name = name,
			fn = fn,
		}
		table.insert(self.cases, case)
	end

	function humb:run()
		local cases = self.cases
		local rpt = self.rpt
		local now = self.now
		local start_at, end_at, elapsed
		local stats = {
			rpt = rpt,
			cases = {}
		}

		self:log('--- Start ---')
		for i = 1, #cases do
			local c = cases[i]
			local fn = c.fn

			self:log('#'..i..': '..c.name)
			start_at = now()
			for j = 1, rpt do
				fn()
			end
			end_at = now()
			elapsed = string.format('%.2f', end_at - start_at)
			table.insert(stats.cases, {
				index = i,
				name = c.name,
				elapsed = elapsed,
			})

			self:log('  Elapsed: '..elapsed)
		end
		self:log('=== End ===')
	end

	humb:init(...)
	return humb
end

return M
