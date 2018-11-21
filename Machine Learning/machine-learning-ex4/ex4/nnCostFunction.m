function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%


a_input=[ones(m,1) X];%5000x401
z_hidden=a_input*Theta1';%5000x401 * 401x25 = 5000x25
a_hidden=[ones(size(z_hidden, 1), 1) sigmoid(z_hidden)];%5000x26
z_L=a_hidden*Theta2';%5000x26 * 26x10 = 5000x10
a_L=sigmoid(z_L);%5000%10
h_X=a_L;


for k=1:num_labels
	y_vec=(y==k);%5000x1
	h=h_X(:,k);%5000x1

	tempA=-1*((log(h)'*y_vec));
	tempB=-1*(log(1.-h)'*(1.-y_vec));
	
	%cost function
	J=J+(tempA+tempB)/m;
end

%cost function with regularization
p = sum(sum(Theta1(:, 2:end).^2, 2))+sum(sum(Theta2(:, 2:end).^2, 2));
J=J + lambda*p/(2*m);

%backpropagation
Y=zeros(num_labels, m);%10x5000
for k=1:num_labels
	y_vec=(y==k);
	Y(k,:)=y_vec';
end
delta_L=a_L-Y';%5000x10 - 5000x10 = 5000x10
delta_hidden=delta_L*Theta2 .*sigmoidGradient([ones(size(z_hidden, 1), 1) z_hidden]);%5000x10 * 10x26 .* 5000x26
delta_hidden=delta_hidden(:,2:end);%5000x25

DELTA_HIDDEN=delta_L'*a_hidden;%10x5000 * 5000x26
DELTA_INPUT=delta_hidden'*a_input;%25x5000 * 5000*401

Theta1_grad=DELTA_INPUT./m;
Theta2_grad=DELTA_HIDDEN./m;








---------------
Y=zeros(m, num_labels);
for k=1:num_labels
	y_vec=(y==k);
	h=h_X(k,:);

	tempA=-1*((log(h)*y_vec));
	tempB=-1*(log(1.-h)*(1.-y_vec));
	J=J+(tempA+tempB)/m;

	Y(:,k)=y_vec;
end


delta_L=a_L'.-Y;
delta_hidden=(delta_L*Theta2.*a_hidden'.*(1-a_hidden)');


Delta_L = delta_L'*a_hidden';
Delta_hidden = delta_hidden'*X;


Theta1_grad = Delta_hidden(2:end,:)./m + (lambda/m)*[zeros(size(Theta1,1), 1) Theta1(:, 2:end)];
Theta2_grad = Delta_L./m + (lambda/m)*[zeros(size(Theta2,1), 1) Theta2(:, 2:end)];
---------------







% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
