describe("number.abbrev.utf8", function()
  local t, brev, bn, tonum
  setup(function()
    t = require "t"
    brev = t.number.abbrev
    bn = brev({prefix='₽', decimals=1}, {'млн', 'миллион', ''}, {'млрд', 'миллиард', 'billion'}, {'трлн', 'триллион'})
    tonum = t.to.number
  end)
  it("common", function()
    assert.is_table(t)
    local k = bn(1)
    assert.equal(1, k[1])
    assert.equal(1, tonum(k))
    assert.equal('₽1млн', tostring(k))
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
    assert.equal(1200000, tonum(bn('1200000')))
    assert.equal(-1200000, tonum(bn('-1200000')))
    assert.equal(1200000, tonum(bn('1200млрд')))
    assert.equal(-1200000, tonum(bn('-1200млрд')))
    assert.equal(1200000, tonum(bn('1.2трлн')))
    assert.equal(-1200000, tonum(bn('-1.2трлн')))
  end)
  it("rounds", function()
    assert.equal(671300, tonum(bn('₽671.3 млрд')))
    assert.equal(671, tonum(bn(671)))
    assert.equal(671, tonum(bn('₽671 млн')))
    assert.equal(671, tonum(bn('₽671.3 млн')))
    assert.equal(5, tonum(bn('<₽5 МЛН')))
    assert.equal(31800, tonum(bn('₽31.8 МЛРД')))
    assert.equal(364100, tonum(bn('₽364.1млрд')))
    assert.equal(26700, tonum(bn('₽26.7млрд')))
    assert.equal(477, tonum(bn('₽477млн')))
    assert.equal(5, tonum(bn('<₽5млн')))
    assert.equal(2800, tonum(bn('₽2.8млрд')))
    assert.equal(95, tonum(bn('₽94.5млн')))
    assert.equal(182, tonum(bn('₽181.9млн')))
    assert.equal(16600, tonum(bn('₽16.6млрд')))
    assert.equal(219, tonum(bn('₽219.3млн')))
    assert.equal(67, tonum(bn('₽66.8млн')))
    assert.equal(36, tonum(bn('₽36.4млн')))
    assert.equal(1900, tonum(bn('₽1.9млрд')))
    assert.equal(18, tonum(bn('₽17.5млн')))
    assert.equal(6, tonum(bn('₽6.2млн')))
    assert.equal(30, tonum(bn('₽29.5млн')))
    assert.equal(24600, tonum(bn('₽24.6млрд')))
    assert.equal(204100, tonum(bn('₽204.1млрд')))
    assert.equal(462, tonum(bn('₽461.7млн')))
    assert.equal(462, tonum(bn('₽461.7млн')))
    assert.equal(462, tonum(bn('₽461.7 млн')))
    assert.equal(462, tonum(bn('₽461.7 млн')))
    assert.equal(359, tonum(bn('₽358.8 млн')))
  end)
  it("string", function()
    assert.equal('0', tostring(bn('₽0')))
    assert.equal('0', tostring(bn('₽0 млрд')))
    assert.equal('₽671.3млрд', tostring(bn('₽671.3 млрд')))
    assert.equal('₽671млн', tostring(bn(671)))
    assert.equal('₽671млн', tostring(bn('₽671 млн')))
    assert.equal('₽671млн', tostring(bn('₽671.3 млн')))
    assert.equal('₽5млн', tostring(bn('<₽5 млн')))
    assert.equal('₽31.8млрд', tostring(bn('₽31.8 млрд')))
    assert.equal('₽364.1млрд', tostring(bn('₽364.1млрд')))
    assert.equal('₽26.7млрд', tostring(bn('₽26.7млрд')))
    assert.equal('₽477млн', tostring(bn('₽477млн')))
    assert.equal('₽5млн', tostring(bn('<₽5млн')))
    assert.equal('₽2.8млрд', tostring(bn('₽2.8млрд')))
    assert.equal('₽2.8млрд', tostring(bn('₽2800млн')))
    assert.equal('₽2.8млрд', tostring(bn('₽2.8 billion')))
    assert.equal('₽95млн', tostring(bn('₽94.5млн')))
    assert.equal('₽182млн', tostring(bn('₽181.9млн')))
    assert.equal('₽16.6млрд', tostring(bn('₽16.6млрд')))
    assert.equal('₽16.7млрд', tostring(bn('₽16.66млрд')))
    assert.equal('₽219млн', tostring(bn('₽219.3млн')))
    assert.equal('₽67млн', tostring(bn('₽66.8млн')))
    assert.equal('₽36млн', tostring(bn('₽36.4млн')))
    assert.equal('₽1.9млрд', tostring(bn('₽1.9млрд')))
    assert.equal('₽18млн', tostring(bn('₽17.5млн')))
    assert.equal('₽6млн', tostring(bn('₽6.2млн')))
    assert.equal('₽30млн', tostring(bn('₽29.5млн')))
    assert.equal('₽24.6млрд', tostring(bn('₽24.6млрд')))
    assert.equal('₽204.1млрд', tostring(bn('₽204.1млрд')))
    assert.equal('₽462млн', tostring(bn('₽461.7млн')))
    assert.equal('₽462млн', tostring(bn('₽461.7млн')))
    assert.equal('₽462млн', tostring(bn('₽461.7 млн')))
    assert.equal('₽462млн', tostring(bn('₽461.7 млн')))
    assert.equal('₽359млн', tostring(bn('₽358.8 млн')))
  end)
end)