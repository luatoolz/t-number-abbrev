describe("number.abbrev.number_format", function()
  local t, fmt
  setup(function()
    t = require 't'
    fmt = t.number.abbrev.number_format
  end)
  it("meta", function()
    assert.is_table(t.number)
    assert.equal('number', getmetatable(t.number).__name)
    assert.equal('abbrev', getmetatable(t.number.abbrev).__name)
    assert.callable(fmt)
  end)
  it("positive", function()
    assert.equal('%s%d%s', fmt())
    assert.equal('%s%d%s', fmt(nil))
    assert.equal('%s%.1f%s', fmt(1))
    assert.equal('%s%.2f%s', fmt(2))
  end)
end)