## costfunction
```
A1 = (-y).*log(1./(1.+e.^(-X*theta)));
A2 = (1.-y).*log(1.-1./(1.+e.^(-X*theta)));
J = sum(A1.-A2)/m;

h = 1./(1.+e.^(-X*theta));
grad = X'*(h.-y)./m;
```

## predict
```
p = sigmoid(X*theta)>=0.5;
```

## costFunctionReg.m
```
A1 = (-y).*log(1./(1.+e.^(-X*theta)));
A2 = (1.-y).*log(1.-1./(1.+e.^(-X*theta)));
J = sum(A1.-A2)/m + lambda/(2*m)*sum(theta.^2);

h = 1./(1.+e.^(-X*theta));
grad = X'*(h.-y)./m + lambda/m*theta;

grad(1, 1) = (X'*(h.-y)./m)(1, 1);
```
