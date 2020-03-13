%Part2: 

clc
clear
set(0,'DefaultFigureWindowStyle','docked')

% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height

side = 1.5;         % Space on side

% Grid size:
dx = 0.0125;        % grid size (horizontal)
dy = 0.0125;        % grid size (vertical)

nmodes = 1;
lambda = 1.55;      % vacuum wavelength
n = 0;
neff_sum = zeros(10,1);
for rw=linspace(0.325,1.0,10)
    n = n + 1;
    [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2,n3],[h1,h2,h3], ...
                                                rh,rw,side,dx,dy); 

    % First consider the fundamental TE mode:

    [Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');
    neff_sum(n) = neff;
    fprintf(1,'neff = %.6f\n',neff);

    figure(1);
    subplot(121);
    [X, Y] = meshgrid(x,y);
    surf(X',Y',Hx(:,:));
    % contourmode(x,y,Hx(:,:));
    title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end

    subplot(122);
    contourmode(x,y,Hy(:,:));
    title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end
end

figure(n+1);
plot(linspace(0.325,1.0,10), neff_sum);
xlabel('Half Ridge Width');
ylabel('n_eff');