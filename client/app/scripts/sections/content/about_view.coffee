React = require('react')
Сomponent = require('app/base/component')
{ Content } = require('app/components')


module.exports = class AboutView extends Сomponent
  title: -> 'Dellee • О проекте'

  render: ->
    <Content>
      <div className="container">
        <h2>О проекте</h2>
        <p>Fusce sit amet purus a tellus porttitor sollicitudin eu in risus. In hac habitasse platea dictumst. Aenean at tortor interdum, dignissim libero eu, ultricies nisl. Etiam fringilla odio at ligula faucibus ultrices. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla gravida aliquam euismod. Donec maximus condimentum volutpat. Etiam malesuada, nisl ut placerat accumsan, leo est gravida nisl, in laoreet eros enim sit amet libero. Nunc in felis dolor. Nulla purus purus, egestas a arcu vitae, interdum blandit lectus. Sed dignissim, felis sit amet tristique auctor, ipsum enim auctor mauris, egestas sodales libero mi nec tortor. Maecenas in eleifend leo.</p>
        <p>Nulla condimentum risus sit amet turpis tincidunt cursus. Morbi nec mi ex. Ut non nisl nec elit sagittis hendrerit. Suspendisse imperdiet felis a urna lacinia venenatis. Vivamus id mi quis mi commodo euismod. Aliquam at eleifend tellus. Ut tincidunt augue enim.</p>
      </div>
    </Content>
