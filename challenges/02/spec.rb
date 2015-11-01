describe 'button_presses' do
  it 'counts the number of pressed buttons' do
    expect(button_presses('')).to eq 0
    expect(button_presses('     ')).to eq 5
    expect(button_presses('1234567890*#')).to eq 39
    expect(button_presses('nvm')).to eq 6
    expect(button_presses('WHERE DO U WANT 2 MEET L8R')).to eq 47
    expect(button_presses('wHeRe DO U want 2 MeeT L8r')).to eq 47
    expect(button_presses('abcdefghijklmnopqrstuvwxyz')).to eq 56
  end
end
