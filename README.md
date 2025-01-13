# humb.lua
humb is an extremely simple Lua library for benchmarking.
It has no dependencies. Just clone this repo in your project directory, and `require` it in your Lua code.

## Installation
```sh
cd your_project
git clone git@github.com:amekusa/humb.lua.git humb
```

## How to use
```lua
local humb = require('humb')
local test = humb:new_test(1000) -- Repeat 1000 times

-- Add test cases to compare
test:case('A', function_A)
test:case('B', function_B)

test:run()   -- Run test cases
test:print() -- Show stats
```

## Options
Instead of a number, you can also pass a table to `humb:new_test()` to customize the behavior.

```lua
-- Default options
humb:new_test({
  rpt      = 1,        -- Times to repeat each test case
  digits   = 2,        -- Number of digits in the fraction part of the time to show
  get_time = os.clock, -- Function to get the time
})
```

### `test:print()`
You can pass a custom function to output the stats. The default value is `print`.

```lua
test:print(vim.notify) -- Recommended for neovim
```

## Lisence
Copyright (c) 2025 Satoshi Soma <noreply@amekusa.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

