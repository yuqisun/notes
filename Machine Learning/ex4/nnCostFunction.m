X=[ones(m,1) X];
z_hidden=Theta1*X';
a_hidden=sigmoid(z_hidden);
a_hidden_cols=size(a_hidden, 2);
a_hidden=[ones(1, a_hidden_cols); a_hidden];
z_L=Theta2*a_hidden;
a_L=sigmoid(z_L);
h_X=a_L;

for k=1:num_labels
	y_vec=(y==k);
	h=h_X(k,:);
	
	tempA=-1*((log(h)*y_vec));
	tempB=-1*(log(1.-h)*(1.-y_vec));
	J=J+(tempA+tempB)/m;
end
