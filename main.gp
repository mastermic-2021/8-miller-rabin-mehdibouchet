n = read("input.txt");

\\ **********************************************************************************
\\  Fonctions de l'exercice :                                                       *
\\                                                                                  *
\\    extract(n): Return s et d tq n = 2^s*d                                        *
\\                                                                                  *
\\    floor_extend(x): floor étendu, utile pour optimiser la recherche d'un         *
\\      entier a < floor( sqrt(n) ) or que floor ne fonctionne pas ici              *
\\      too many digits                                                             *
\\                                                                                  *
\\    find_witness(n): Recherche d'un témoin de Miller a tq Mod(a, n)^(n-1) = 1     *
\\  Méthode:                                                                        *
\\    On détermine un témoin de Miller a tq Mod(a,n)^(n-1) = 1 de tel sorte         *
\\    à ce que gcd(a-1, n) = p et gcd(a+1, n) = q                                   *
\\ **********************************************************************************


extract(n) = {
    my(s);
    s= 0;
    while(n%2 == 0, n/= 2; s++);
    d= n;
    [s, d];
}

floor_extend(x)=local(t,e);t=truncate(x,&e);t-(1<<max(e,0));

find_witness(n)= {
    [s,d]= extract(n-1);
    a= 2;
    B= floor_extend( sqrt(n) );
    t= a;
    while(gcd(a, n) == 1,
        a= random(B-1)+2;
        until(lift(Mod(a,n)^(n-1)) == 1 && gcd(a,n) == 1, a= random(B-1)+2);
        t= a;
        a= lift( Mod(a,n)^d);
        
        for(r=1, s-1, 
            a= lift(Mod(a,n)^2);
            if(a==-1, break);
        );
        if(a != -1, return(a))
    );
}

a= random(n-4)+2;

a= find_witness(n);
p= gcd(a-1,n);
q= gcd(a+1,n);

if(p < q, print(p), print(q));