function f(d,t,n,m)
  if(m==1)
    t(d)=n;
    t
    return;
  end

  for i=0:1:n
    t(d)=i;
    %fprintf('i:%d,d:%d,n:%d,m:%d\n',i,d,n,m);
    f(d+1,t,n-i,m-1);
  end
end
