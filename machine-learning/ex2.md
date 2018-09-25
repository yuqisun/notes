## costfunction
```
A1 = (-y).*log(1./(1.+e.^(-X*theta)));
A2 = (1.-y).*log(1.-1./(1.+e.^(-X*theta)));
J = sum(A1.-A2)/m;

h = 1./(1.+e.^(-X*theta));
grad = X'*(h.-y)./m;
```

