This Matlab script is to calculate the phase refractive index, group velocity index, group velocity dispersion, third-order dispersion of glasses from SCHOTT and CDGM.

Sellmeier equation or Cauchy's equation is called dispersion formula, and can be used to calculate the phase refractive index as a function of wavelength. For Sellmeier equation,
$$
n(\lambda) ^2 = 1 + B_1 \cdot \lambda^2 / (\lambda^2 - C_1) + B_2 \cdot \lambda^2 / (\lambda^2 - C_2) + B3 \cdot \lambda^2 / (\lambda^2 - C_3)
$$

where $\lambda$ is the wavelength in $\mu $m. $B_1, C_1, B_2, C_2, B_3, C_3 $ are constants of dispersion formula, and sometimes written as $K_1, L_1, K_2, L_2, K_3, L_3$.

For Cauchy's equation,
$$
n(\lambda) ^2 = A_0 + A_1 \cdot \lambda^2 + A_2 \cdot \lambda ^{-2} +  A_3 \cdot \lambda^{-4} + A_4 \cdot \lambda^{-6} + A_5 \cdot \lambda^{-8}
$$
$A_0, A_1, A_2, A_3, A_4, A_5$ are constants of dispersion formula.

The formulae for calculating group refractive index, group velocity dispersion, and third-order dispersion are listed as below,
$$
{{n_g} = n\left( \lambda  \right) - \lambda \frac{{\partial n\left( \lambda  \right)}}{{\partial \lambda }}}
$$

$$
{GVD\left( \lambda  \right) = \frac{{{\lambda ^3}}}{{2\pi c}}\frac{{{\partial ^2}n\left( \lambda  \right)}}{{\partial {\lambda ^2}}}}
$$

$$
{TOD\left( \lambda  \right) =  - \frac{{{\lambda ^4}}}{{4{\pi ^2}{c^3}}}\left[ {3\frac{{{\partial ^2}n\left( \lambda  \right)}}{{\partial {\lambda ^2}}} + \lambda \frac{{{\partial ^3}n\left( \lambda  \right)}}{{\partial {\lambda ^3}}}} \right]}
$$

where $c$ is the light speed in $\mu$m/fs.

<img src="https://i.loli.net/2021/05/07/PVJDcINXC9EujLM.png" alt="image-20210507195336772" style="zoom: 67%;" />

<img src="https://i.loli.net/2021/05/07/malQwvTCr7b1qYi.png" alt="image-20210507195438541" style="zoom:67%;" />

**Reference**

[http://toolbox.lightcon.com/tools/dispersionparameters/](http://toolbox.lightcon.com/tools/dispersionparameters/)

