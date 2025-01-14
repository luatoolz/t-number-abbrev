describe("number.abbrev.precision", function()
  local t, precision
  setup(function()
    t = require "t"
    precision = t.number.abbrev.precision
  end)
  it("meta", function()
    assert.callable(precision)
  end)
  it("positive", function()
    assert.is_nil(precision(1.11))
    assert.is_nil(precision(1.11, 0))
    assert.equal(1, precision(1.11, 1))
    assert.equal(2, precision(1.11, 2))

    assert.is_nil(precision(1.01))
    assert.is_nil(precision(1.01, 0))
    assert.is_nil(precision(1.01, 1))
    assert.equal(2, precision(1.01, 2))

    assert.is_nil(precision(1.1))
    assert.is_nil(precision(1.1, 0))
    assert.equal(1, precision(1.1, 1))
    assert.equal(1, precision(1.1, 2))

    assert.is_nil(precision(1))
    assert.is_nil(precision(1, 0))
    assert.is_nil(precision(1, 1))
    assert.is_nil(precision(1, 2))


    assert.is_nil(precision(-1.11))
    assert.is_nil(precision(-1.11, 0))
    assert.equal(1, precision(-1.11, 1))
    assert.equal(2, precision(-1.11, 2))

    assert.is_nil(precision(-1.01))
    assert.is_nil(precision(-1.01, 0))
    assert.is_nil(precision(-1.01, 1))
    assert.equal(2, precision(-1.01, 2))

    assert.is_nil(precision(-1.1))
    assert.is_nil(precision(-1.1, 0))
    assert.equal(1, precision(-1.1, 1))
    assert.equal(1, precision(-1.1, 2))

    assert.is_nil(precision(-1))
    assert.is_nil(precision(-1, 0))
    assert.is_nil(precision(-1, 1))
    assert.is_nil(precision(-1, 2))
  end)
end)