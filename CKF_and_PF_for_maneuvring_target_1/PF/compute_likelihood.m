function gz_vals= compute_likelihood(model,z,X)

% compute likelihood vector g= [ log_g(z|x_1), ... , log_g(z|x_M) ] -
% this is for bearings and range case with additive Gaussian noise

M= size(X,2);
P= X(model.pos_idx,:);
Phi= zeros(2,M);
Phi(1,:)= atan2(P(2,:),P(1,:));
Phi(2,:)= sqrt(sum(P.^2));

e_sq= sum( (diag(1./diag(model.D))*(repmat(z,[1 M])- Phi)).^2 );
gz_vals= exp(-e_sq/2 - log(2*pi*prod(diag(model.D))));

%%---using mvnpdf--------

%gz_vals = mvnpdf((z-Phi)', zeros(1,size(z,1)), model.R);
