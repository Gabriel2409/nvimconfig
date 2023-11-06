local status_ok, animate = pcall(require, "mini.animate")
if not status_ok then
  return {}
end

return {
  "echasnovski/mini.animate",
  opts = {
    scroll = {
      timing = animate.gen_timing.linear({ duration = 20, unit = "total" }),
    },
  },
}
