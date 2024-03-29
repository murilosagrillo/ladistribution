  <div>
  <h1> The LA and LI distributions </h1> 
</div>

<div>
  <h2> The repository </h2> 
</div>
This repository contains the "ladistribution" package in the R programming language, which provides computational functions to handle the LA and LI distributions, introduced by Sagrillo et al. (2023) for modelling synthetic aperture radar (SAR) images. 

<h2> Available functions in the package: </h2>

<h2>About LA distribution:</h2>

<ul>
  <li>probability density function (dla);</li>
  <li>cumulative density function (pla);</li>
  <li>quantile function (qla) and;</li>
  <li>function for generating pseudo-random numbers (rla) of the LA distribution.</li>
</ul>  

<h2>About LI distribution:</h2>

<ul>
  <li>probability density function (dli);</li>
  <li>cumulative density function (pli);</li>
  <li>quantile function (qli) and;</li>
  <li>function for generating pseudo-random numbers (rli) of the LI distribution.</li>
</ul>  

In addition, the lafit and lifit functions are available for parameter estimation of LA and LI distributions, respectively. These functions return the maximum likelihood estimates of the parameters, a histogram of the data with the fit distribution, and goodness-of-fit measures useful for model selection.

<div>
  <h2> How to use the package </h2> 
</div>

<ol>
	<li>Initialize the R language environment;</li>
	<li>Run the code below:
	<ul>
		<li>install.packages(&#39;devtools&#39;) #installs package devtools which is a collection of package development tools</li>
		<li>library(devtools) #loads the functions from the devtools package into memory</li>
		<li>install_github(&quot;murilosagrillo/ladistribution&quot;) #installs the ladistribution package, with all the package functions.</li>
		<li>library(ladistribution) #loads the functions from the ladistribution package into memory;</li>
	</ul>
	</li>
	<li>From this step, just choose the function of interest&nbsp;and run it with the input arguments of interest.</li>
</ol>


<div>
  <h2> Reference </h2> 
</div>
@ARTICLE{10082991,<br>
  author={Sagrillo, Murilo and Guerra, Renata Rojas and Bayer, Fábio M. and Machado, Renato},<br>
  journal={IEEE Transactions on Geoscience and Remote Sensing}, <br>
  title={The LA Distribution: An Approximation of the G0A Distribution for Amplitude SAR Image Modeling}, <br>
  year={2023},<br>
  volume={61},<br>
  number={},<br>
  pages={1-8},<br>
  doi={10.1109/TGRS.2023.3262480}}
