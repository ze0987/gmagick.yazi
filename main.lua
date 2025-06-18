local M = {}

function M:peek(job)
	local start, cache = os.clock(), ya.file_cache(job)
	if not cache then
		return
	end

	local ok, err = self:preload(job)
	if not ok or err then
		return
	end

	ya.sleep(math.max(0, rt.preview.image_delay / 1000 + start - os.clock()))

	local _, err = ya.image_show(cache, job.area)
	ya.preview_widget(job, err and ui.Text(err):area(job.area):wrap(ui.Wrap.YES))
end

function M:seek() end

function M:preload(job)
	local cache = ya.file_cache(job)
	if not cache or fs.cha(cache) then
		return true
	end

	local cmd = M.with_limit()
	if job.args.flatten then
		cmd = cmd:arg("-flatten")
	end

	-- stylua: ignore
	local status, err = cmd:arg {
		tostring(job.file.url), "-auto-orient", "-strip",
		"-thumbnail", string.format("%dx%d", rt.preview.max_width, rt.preview.max_height),
		"-quality", rt.preview.image_quality,
		string.format("jpg:%s", cache),
	}:status()

	if status then
		return status.success
	else
		return true, Err("Failed to start `gm`, error: %s", err)
	end
end

function M:spot(job) require("file"):spot(job) end

function M.with_limit()
	local cmd = Command("gm"):arg { "convert" }
	local img_bound = rt.tasks.image_bound[1] * rt.tasks.image_bound[2]
	if rt.tasks.image_alloc > 0 then
		cmd:arg { "-limit", "Memory", rt.tasks.image_alloc, "-limit", "Disk", "1MB" }
	end
	if img_bound > 0 then
		cmd:arg { "-limit", "Pixels", img_bound }
	end
	return cmd
end

return M
