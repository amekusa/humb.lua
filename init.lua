----- HUMmingBird -----
-- github.com/amekusa

local NS = (...)

local M = {}
function M:new_test(...)
	local humb = {}

	function humb:init(opts)
		if type(opts) == 'number' then
			opts = {rpt = opts}
		end
		self.cases = {}
		self.logs = {}
		self.rpt = opts.rpt or 1
		self.get_time = opts.get_time or os.clock
		self.digits = opts.digits or 2
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
		local get_time = self.get_time
		local time_fmt = '%.'..self.digits..'f'
		local stats = {
			rpt = rpt,
			cases = {}
		}

		self:log('--- Start ---')
		self:log('Repeats: '..rpt)

		for i = 1, #cases do
			local c = cases[i]
			local fn = c.fn
			local start_at, end_at, elapsed

			self:log('#'..i..': '..c.name)
			start_at = get_time()
			for j = 1, rpt do
				fn()
			end
			end_at = get_time()
			elapsed = end_at - start_at

			local stat = {
				index = i,
				name = c.name,
				elapsed = string.format(time_fmt, elapsed),
				average = string.format(time_fmt, elapsed / rpt),
			}
			table.insert(stats.cases, stat)
			self:log('  Elapsed: '..stat.elapsed)
			self:log('  Average: '..stat.average)
		end
		self:log('=== End ===')
	end

	humb:init(...)
	return humb
end

return M
