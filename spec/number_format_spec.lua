describe("number.abbrev.number_format", function()
  local t, fmt
  setup(function()
    t = require "t"
    fmt = t.number.abbrev.number_format
  end)
  it("meta", function()
    assert.callable(fmt)
  end)
  it("positive", function()
    assert.equal('%s%d%s', fmt())
    assert.equal('%s%d%s', fmt(nil))
    assert.equal('%s%.1f%s', fmt(1))
    assert.equal('%s%.2f%s', fmt(2))
  end)
end)