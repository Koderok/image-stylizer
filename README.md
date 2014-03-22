# Image stylization

This program abstracts images by removing details from them and makes them cartoon-like. It is based on the paper [Stylization and Abstraction of Photographs](https://www.cs.rutgers.edu/~decarlo/pubs/sg02.pdf).

## How to run

<pre>
main (<i>image_name</i>,<i>num_colors</i>)
</pre>

*num_colors* specifies number of colors in the output image. Smaller this value, more abstraction happens in the output image.

Example:

<pre>
main ("scarlet.jpg", 20)
</pre>

![Demo](https://raw.github.com/koderok/image-stylize/master/assets/demo.png)
