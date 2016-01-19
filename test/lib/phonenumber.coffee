{ expect } = require('chai')
phonenumber = require('lib/phonenumber')


describe 'Phonenumber', ->
  it 'should delete unneccessary space', ->
    expect(phonenumber('  +7  ( 773) - 456 78-21 ')).to.equal('+77734567821')

  it 'should replace 8 with country code', ->
    expect(phonenumber('8 777 890 21-43')).to.equal('+77778902143')

  it 'should add country number', ->
    expect(phonenumber('7778902143')).to.equal('+77778902143')

  it 'should return INVALID if phone incorrect', ->
    expect(phonenumber('777890214')).to.equal('INVALID')
    expect(phonenumber('+777890214')).to.equal('INVALID')
    expect(phonenumber('89777890214')).to.equal('INVALID')
    expect(phonenumber('7578906767')).to.equal('INVALID')
