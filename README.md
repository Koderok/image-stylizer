# Image stylization

This program abstracts images by removing details from them and makes them cartoon-like. It is based on the paper [Stylization and Abstraction of Photographs](https://www.cs.rutgers.edu/~decarlo/pubs/sg02.pdf).

## How to run

<pre>
main (*image_name*, *num_colors*)
</pre>

*num_colors* specifies number of colors in the output image. Smaller this value, more abstraction happens in the output image.

Example:

<pre>
main ("scarlet.jpg", 20)
</pre>

![Input image](https://raw.github.com/koderok/image-stylize/master/scarlet.jpg)
![Result image](https://raw.github.com/koderok/image-stylize/master/scarlet-result.jpg)
