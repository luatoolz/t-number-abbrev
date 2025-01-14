describe("number.abbrev.operations", function()
  local t, brev, bn, tonum
  setup(function()
    t = require "t"
    brev = t.number.abbrev
    bn = brev({scale=1000, prefix='$', precision=0, decimals=1}, {'m', 'Million', ''}, {'b', 'Billion'}, {'t', 'Trillion'})
    tonum = t.to.number
  end)
  it("common", function()
    assert.is_table(t)
    local k = bn(1)
    assert.equal(1, k[1])
    assert.equal(1, tonum(k))
    assert.equal('$1m', tostring(k))
    assert.is_table(bn)
  end)
  describe("operation", function()
    it("a + b", function()
      assert.equal(bn(0), bn(0) + 0)
      assert.equal(bn(0), bn(0) + '0')

      assert.equal(bn(0), bn(0) + bn('0'))
      assert.equal(bn(0), bn(0) + bn('0m'))
      assert.equal(bn(0), bn(0) + bn('$0'))
      assert.equal(bn(0), bn(0) + bn('$0m'))

      assert.equal(bn('-1'), bn(0) + bn(-1))
      assert.equal(bn(-1), bn(0) + bn('-1'))

      assert.equal(bn(464), bn(2) + 461.7)
      assert.equal(bn(464), bn(2) + '461.7')
      assert.equal(bn(464), bn(2) + bn(461.7))
      assert.equal(bn(464), bn(2) + bn('$461.7m'))
    end)
    it("a - b", function()
      assert.equal(bn(0), bn(0) - 0)
      assert.equal(bn(0), bn(0) - '0')
      assert.equal(bn(0), bn(1) - 1)
      assert.equal(bn(0), bn(1) - '1')
      assert.equal(bn('1999'), bn('2b') - 1)
      assert.equal(bn('1999'), bn('2b') - '1')
    end)
    it("a * b", function()
      assert.equal(bn(0), bn(0) * 0)
      assert.equal(bn(0), bn(0) * '0')
      assert.equal(bn(1), bn(1) * 1)
      assert.equal(bn(1), bn(1) * '1')
      assert.equal(bn(2000), bn('2b') * 1)
      assert.equal(bn('2b'), bn('2b') * '1')
    end)
    it("-x", function()
      assert.equal(bn(0), -bn(0))
      assert.equal(bn(0), -bn('0'))
      assert.equal(bn(-1), -bn(1))
      assert.equal(bn('-1'), -bn('1'))
      assert.equal(bn(-2000), -bn('2b'))
      assert.equal(bn('2b'), -bn('-2b'))
    end)
    it("a >= b", function()
      assert.is_true(bn(0) >= bn(0))
      assert.is_true(bn(0) >= bn('0'))
      assert.is_true(bn(1) >= bn(1))
      assert.is_true(bn(1) >= bn('1'))
      assert.is_true(bn(1) >= bn(0))
      assert.is_true(bn(1) >= bn('0'))
      assert.is_true(bn('2b') >= bn(1))
      assert.is_true(bn('2b') >= bn('1'))
    end)
    it("a > b", function()
      assert.is_false(bn(0) > bn(0))
      assert.is_false(bn(0) > bn('0'))
      assert.is_false(bn(1) > bn(1))
      assert.is_false(bn(1) > bn('1'))

      assert.is_true(bn(1) > bn(0))
      assert.is_true(bn(1) > bn('0'))
      assert.is_true(bn('2b') > bn(1))
      assert.is_true(bn('2b') > bn('1'))
    end)
  end)
end)