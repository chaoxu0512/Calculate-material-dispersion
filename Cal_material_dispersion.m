close all;
% This script is to calculate the phase refractive index, group velocity
% index, group velocity dispersion, third-order dispersion of materials.
% Reference: http://toolbox.lightcon.com/tools/dispersionparameters/

% For Sellmeier equation:
% n(lambda) ^2 = 1 + B1 * lambda^2 / (lambda^2 - C1) + B2 * lambda^2 / (lambda^2 - C2) + B3 * lambda^2 / (lambda^2 - C3); 
% the unit for lambda is um.

% For Cauchy's equation:
% n(lambda) ^2 = A0 + A1 * lambda^2 + A2 * lambda^(-2) +  A3 * lambda^(-4) + A4 * lambda^(-6) + A5 * lambda^(-8)
% the unit for lambda is um.

glass_vendor_model = ["CDGM", "H-ZF13"];
glass_vendor = glass_vendor_model(1);
glass_model = glass_vendor_model(2);

syms lambda
if glass_vendor == "SCHOTT"
    glass_cotalogue = readcell('schott_optical_glass_catalogue.xlsx', 'Sheet', 'Datatable', 'Range', 'A4:L127');
    % Find the index of the glass model
    glass_model_index = cellfun(@(x)isequal(x, glass_model), glass_cotalogue);
    [glass_model_row, glass_model_col] = find(glass_model_index);
    % Constants of Dispersion Formula: B1, C1, B2, C2, B3, C3;  
    B1 = glass_cotalogue{glass_model_row, 7};
    B2 = glass_cotalogue{glass_model_row, 8};
    B3 = glass_cotalogue{glass_model_row, 9};
    C1 = glass_cotalogue{glass_model_row, 10};
    C2 = glass_cotalogue{glass_model_row, 11};
    C3 = glass_cotalogue{glass_model_row, 12};
    % Sellmeier equation
    n = power(1 + B1 * lambda^2 / (lambda^2 - C1) + B2 * lambda^2 / (lambda^2 - C2) + B3 * lambda^2 / (lambda^2 - C3), 0.5);
elseif glass_vendor == "CDGM"
    glass_cotalogue = readcell('cdgm_optical_glass_catalogue.xlsx', 'Sheet', 'optical glass', 'Range', 'A1:AM264');
    glass_model_index = cellfun(@(x)isequal(x, glass_model), glass_cotalogue);
    [glass_model_row, glass_model_col] = find(glass_model_index);
    % Constants of Dispersion Formula: K1, L1, K2, L2, K3, L3
    K1 = glass_cotalogue{glass_model_row, 28};
    L1 = glass_cotalogue{glass_model_row, 29};
    K2 = glass_cotalogue{glass_model_row, 30};
    L2 = glass_cotalogue{glass_model_row, 31};
    K3 = glass_cotalogue{glass_model_row, 32};   
    L3 = glass_cotalogue{glass_model_row, 33};
    if ~isnumeric(K1)
        % Constants of Dispersion Formula: A0, A1, A2, A3, A4, A5
        A0 = glass_cotalogue{glass_model_row, 34};
        A1 = glass_cotalogue{glass_model_row, 35};
        A2 = glass_cotalogue{glass_model_row, 36};
        A3 = glass_cotalogue{glass_model_row, 37};
        A4 = glass_cotalogue{glass_model_row, 38};
        A5 = glass_cotalogue{glass_model_row, 39};
        % Cauchy's equation
        n = power(A0+ A1 * lambda^2 + A2 * lambda^(-2) +  A3 * lambda^(-4) + A4 * lambda^(-6) + A5 * lambda^(-8), 0.5);
    else
        % Sellmeier equation
        n = power(1 + K1 * lambda^2 / (lambda^2 - L1) + K2 * lambda^2 / (lambda^2 - L2) + K3 * lambda^2 / (lambda^2 - L3), 0.5);
    end 
end

% Calculate the derivative
dn_dlambda = diff(n, 1);
d2n_dlambda2 = diff(n, 2);
d3n_dlambda3 = diff(n, 3);

% Group velocity index
n_g = n - lambda * dn_dlambda;
% Group velocity dispersion
c = 3E14; % the unit for light speed is um/s
GVD = lambda^3 / (2 * pi * c^2) * d2n_dlambda2; % the unit for GVD is s^2/um
GVD = GVD * 10^33; % the unit for GVD is fs^2/mm
% Third-order dispersion
TOD = - lambda^4 / (4 * pi^2 * c^3)  * (3 * d2n_dlambda2 + lambda * d3n_dlambda3); % unit for TOD is s^3/um
TOD = TOD * 10^48;  % unit for TOD is fs^3/mm

% Calculate numerical value and plot
lambda_in_double = 0.400:0.001:2; % the unit is um
n = double(subs(n, lambda, lambda_in_double));
n_g = double(subs(n_g, lambda, lambda_in_double));
GVD = double(subs(GVD, lambda, lambda_in_double));
TOD = double(subs(TOD, lambda, lambda_in_double));

figure (1);
plot(lambda_in_double, n);
hold on;
plot(lambda_in_double, n_g);
title(glass_model + ' from ' + glass_vendor);
legend('Phase refractive index', 'Group refractive index');
xlabel('Wavelength (\mum)');
ylabel('PRI, GRI');
grid on;

figure (2);
plot(lambda_in_double, GVD);
hold on;
plot(lambda_in_double, TOD);
title(glass_model + ' from ' + glass_vendor);
legend('Group velocity dispersion', 'Third-order dispersion');
xlabel('Wavelength (\mum)');
ylabel('GVD (fs^2/mm), TOD (fs^3/mm)')
grid on;

