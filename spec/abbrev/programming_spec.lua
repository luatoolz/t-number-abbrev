describe("number.abbrev.programming", function()
  local t, abbrev, bn, tonum, kb, mb, gb
  setup(function()
    t = require "t"
    abbrev = t.number.abbrev
    bn = abbrev({scale=1024, precision=0, decimals=1}, {'B','b'}, {'KB','kb'}, {'MB','mb'}, {'GB','gb'}, {'TB','tb'})
    tonum = t.to.number
    kb = 1024
    mb = 1024*1024
    gb = 1024*1024*1024
  end)
  it("common", function()
    assert.is_table(t)
    local k = bn(1)
    assert.equal(1, k[1])
    assert.equal(1, tonum(k))
    assert.equal('1B', tostring(k))
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
    assert.equal(8, tonum(bn('8')))

    assert.equal(0, tonum(bn('0b')))
    assert.equal(1, tonum(bn('1b')))
    assert.equal(-1, tonum(bn('-1b')))

    assert.equal(1.5*1024, tonum(bn('1.5kb')))

    assert.equal(1200, tonum(bn('1200b')))
    assert.equal(-1200, tonum(bn('-1200b')))

    assert.equal(1200000, tonum(bn('1200000b')))
    assert.equal(-1200000, tonum(bn('-1200000b')))
    assert.equal(1200*kb, tonum(bn('1200kb')))
    assert.equal(-1200*kb, tonum(bn('-1200kb')))
    assert.equal(1200*mb, tonum(bn('1200mb')))
    assert.equal(-1200*mb, tonum(bn('-1200mb')))

    assert.equal(1.25*mb, tonum(bn('1.25 mb')))
  end)
  it("rounds", function()
    assert.equal(671.25*gb, tonum(bn('671.25 gb')))
    assert.equal(671, tonum(bn(671)))
    assert.equal(671*mb, tonum(bn('671 mb')))
    assert.equal(671.25*mb, tonum(bn('671.25 mb')))
    assert.equal(5, tonum(bn('<5 b')))
    assert.equal(math.round(31.8*gb), tonum(bn('31.8 gb')))
    assert.equal(math.round(364.1*kb), tonum(bn('364.1KB')))
  end)
  it("string", function()
    assert.equal('0', tostring(bn('0')))
    assert.equal('0', tostring(bn('0 gb')))
    assert.equal('671.3GB', tostring(bn('671.3 gb')))
    assert.equal('671B', tostring(bn(671)))
    assert.equal('671MB', tostring(bn('671 mb')))
    assert.equal('671B', tostring(bn('671.3b')))
    assert.equal('671.3MB', tostring(bn('671.3 mb')))
    assert.equal('5MB', tostring(bn('<5 mb')))
    assert.equal('31.8GB', tostring(bn('31.8 gb')))
    assert.equal('364B', tostring(bn('364.1B')))
    assert.equal('27B', tostring(bn('26.7B')))
    assert.equal('477MB', tostring(bn('477MB')))
    assert.equal('5MB', tostring(bn('<5Mb')))
    assert.equal('2.8GB', tostring(bn('2.8gb')+'0.01gb'))
    assert.equal('94.5MB', tostring(bn('94.5MB')))
    assert.equal('181.9MB', tostring(bn('181.9mb')))
    assert.equal('17B', tostring(bn('16.6B')))
    assert.equal('219.3MB', tostring(bn('219.3mb')))
    assert.equal('66.8MB', tostring(bn('66.8mb')))
    assert.equal('36.4MB', tostring(bn('36.4mb')))
    assert.equal('1.9GB', tostring(bn('1.9gB')))
    assert.equal('17.5MB', tostring(bn('17.5mb')))
    assert.equal('6.2MB', tostring(bn('6.2mb')))
    assert.equal('29.5MB', tostring(bn('29.5mb')))
    assert.equal('25B', tostring(bn('24.6B')))
    assert.equal('204B', tostring(bn('204.1B')))
    assert.equal('461.7MB', tostring(bn('461.7mb')))
    assert.equal('358.8MB', tostring(bn('358.8 mb')))
  end)
end)