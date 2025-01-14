describe("number.abbrev.fin", function()
  local t, abbrev, bn, tonum, k, m, b
  setup(function()
    t = require "t"
    abbrev = t.number.abbrev
    bn = abbrev({scale=1000, prefix='$', precision=2, decimals=2}, '', {'k'}, {'m', 'Million'}, {'b', 'Billion'}, {'t', 'Trillion'})
    tonum = t.to.number
    k, m, b = 10^3, 10^6, 10^9
  end)
  it("common", function()
    assert.is_table(t)
    local x = bn(1)
    assert.equal(1, x[1])
    assert.equal(1, tonum(x))
    assert.equal('$1', tostring(x))
    assert.is_table(bn)
  end)
  it("init", function()
    assert.equal(0, tonum(bn(0)))
    assert.equal(1, tonum(bn(1)))
    assert.equal(-1, tonum(bn(-1)))

    assert.equal(1, tonum(bn(1 - 0.0001)))
    assert.equal(-1, tonum(bn(-1 - 0.0001)))
    assert.equal(1, tonum(bn(1 + 0.0001)))
    assert.equal(-1, tonum(bn(-1 + 0.0001)))

    assert.equal(1200, tonum(bn(1200)))
    assert.equal(-1200, tonum(bn(-1200)))
    assert.equal(1200000, tonum(bn(1200000)))
    assert.equal(-1200000, tonum(bn(-1200000)))

    assert.equal(0, tonum(bn('0')))
    assert.equal(1, tonum(bn('1')))
    assert.equal(-1, tonum(bn('-1')))
    assert.equal(1200, tonum(bn('1200')))
    assert.equal(-1200, tonum(bn('-1200')))
    assert.equal(1200*k, tonum(bn('1200k')))
    assert.equal(-1200000, tonum(bn('-1200000')))
    assert.equal(1200000, tonum(bn('1200k')))
    assert.equal(-1200000, tonum(bn('-1200k')))
    assert.equal(1200000, tonum(bn('1.2m')))
    assert.equal(-1200000, tonum(bn('-1.2m')))
  end)
  it("rounds", function()
    assert.equal(671300000, tonum(bn('$671.3 Million')))
    assert.equal(671, tonum(bn(671)))
    assert.equal(671*m, tonum(bn('$671 Million')))
    assert.equal(671.3*m, tonum(bn('$671.3 Million')))
    assert.equal(671.37*m, tonum(bn('$671.37 Million')))

    assert.equal(671.378*m, tonum(bn('$671.378 Million')))
    assert.equal(bn('$671.378 Million'), bn(671.378*m))
    assert.equal(bn('$671.378 k'), bn(671.378*k))
    assert.equal(bn('$671378'), bn(671.378*k))

    assert.equal(bn('$671.37'), bn(671.373))
    assert.equal(bn('$671.38'), bn(671.378))

    assert.equal(5*m, tonum(bn('<$5 Million')))
    assert.equal(31.8*b, tonum(bn('$31.8 Billion')))
    assert.equal(364.1*b, tonum(bn('$364.1B')))
    assert.equal(26.7*b, tonum(bn('$26.7B')))
    assert.equal(477*m, tonum(bn('$477M')))
    assert.equal(5*m, tonum(bn('<$5M')))
    assert.equal(2.8*b, tonum(bn('$2.8B')))
    assert.equal(94.5*m, tonum(bn('$94.5M')))
    assert.equal(181.9*m, tonum(bn('$181.9M')))
    assert.equal(bn(16.6*b), bn('$16.6B'))
    assert.equal(219.3*m, tonum(bn('$219.3M')))
    assert.equal(66.8*m, tonum(bn('$66.8M')))
    assert.equal(36.4*m, tonum(bn('$36.4M')))
    assert.equal(1.9*b, tonum(bn('$1.9B')))
    assert.equal(17.5*m, tonum(bn('$17.5M')))
    assert.equal(6.2*m, tonum(bn('$6.2M')))
    assert.equal(29.5*m, tonum(bn('$29.5M')))
    assert.equal(24.6*b, tonum(bn('$24.6B')))
    assert.equal(204.1*b, tonum(bn('$204.1B')))
    assert.equal(461.7*m, tonum(bn('$461.7Million')))
    assert.equal(358.8*m, tonum(bn('$358.8 Million')))
  end)
  it("string", function()
    assert.equal('0', tostring(bn('$0')))
    assert.equal('$1', tostring(bn('$1')))
    assert.equal('$1.1', tostring(bn('$1.1')))
    assert.equal('$1.1', tostring(bn('$1.10')))
    assert.equal('$1.01', tostring(bn('$1.01')))
    assert.equal('0', tostring(bn('$0 Billion')))
    assert.equal('$671.3b', tostring(bn('$671.3 Billion')))
    assert.equal('$671', tostring(bn(671)))
    assert.equal('$671m', tostring(bn('$671 Million')))
    assert.equal('$671.3m', tostring(bn('$671.3 Million')))
    assert.equal('$671.33m', tostring(bn('$671.33 Million')))
    assert.equal('$5m', tostring(bn('<$5 Million')))
    assert.equal('$31.8b', tostring(bn('$31.8 Billion')))
    assert.equal('$364.1b', tostring(bn('$364.1B')))
    assert.equal('$26.7b', tostring(bn('$26.7B')))
    assert.equal('$477m', tostring(bn('$477M')))
    assert.equal('$5m', tostring(bn('<$5M')))
    assert.equal('$2.8b', tostring(bn('$2.8B')))
    assert.equal('$94.5m', tostring(bn('$94.5M')))
    assert.equal('$181.9m', tostring(bn('$181.9M')))
    assert.equal('$16.6b', tostring(bn('$16.6B')))
    assert.equal('$219.3m', tostring(bn('$219.3M')))
    assert.equal('$66.8m', tostring(bn('$66.8M')))
    assert.equal('$36.44m', tostring(bn('$36.44M')))
    assert.equal('$1.9b', tostring(bn('$1.9B')))
    assert.equal('$17.5m', tostring(bn('$17.5M')))
    assert.equal('$6.2m', tostring(bn('$6.2M')))
    assert.equal('$29.5m', tostring(bn('$29.5M')))
    assert.equal('$24.6b', tostring(bn('$24.6B')))
    assert.equal('$204.1b', tostring(bn('$204.1B')))
    assert.equal('$461.7m', tostring(bn('$461.7Million')))
    assert.equal('$461.7m', tostring(bn('$461.7m')))
    assert.equal('$461.7m', tostring(bn('$461.7 M')))
    assert.equal('$461.7m', tostring(bn('$461.7 Million')))
    assert.equal('$358.88m', tostring(bn('$358.88 Million')))
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

      assert.equal(bn(463.7), bn(2) + 461.7)
      assert.equal(bn(463.7), bn(2) + '461.7')
      assert.equal(bn(463.7), bn(2) + bn(461.7))
      assert.equal(bn(461700002), bn(2) + bn('$461.7m'))
    end)
    it("a - b", function()
      assert.equal(bn(0), bn(0) - 0)
      assert.equal(bn(0), bn(0) - '0')
      assert.equal(bn(0), bn(1) - 1)
      assert.equal(bn(0), bn(1) - '1')
      assert.equal(bn('1999999999'), bn('2b') - 1)
      assert.equal(bn('1999999999'), bn('2b') - '1')
    end)
    it("a * b", function()
      assert.equal(bn(0), bn(0) * 0)
      assert.equal(bn(0), bn(0) * '0')
      assert.equal(bn(1), bn(1) * 1)
      assert.equal(bn(1), bn(1) * '1')
      assert.equal(bn(2000000000), bn('2b') * 1)
      assert.equal(bn('2b'), bn('2b') * '1')
    end)
    it("-x", function()
      assert.equal(bn(0), -bn(0))
      assert.equal(bn(0), -bn('0'))
      assert.equal(bn(-1), -bn(1))
      assert.equal(bn('-1'), -bn('1'))
      assert.equal(bn(-2000000000), -bn('2b'))
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