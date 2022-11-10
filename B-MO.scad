module rectangulo(x,y,z){
    //para hacer un prisma de base rectangular
 hull()
  { polyhedron (points=[[0,0,0],[0,y,0],[0,y,z],[0,0,z]],faces=[[0,1,2,3]]);            
    polyhedron (points=[[x,0,0],[x,y,0],[x,y,z],[x,0,z]],faces=[[0,1,2,3]]);            
    polyhedron (points=[[0,0,z],[0,y,z],[x,y,z],[x,0,z]],faces=[[0,1,2,3]]);            
    polyhedron (points=[[0,y,0],[x,y,0],[x,y,z],[0,y,z]],faces=[[0,1,2,3]]);            
    polyhedron (points=[[0,0,0],[x,0,0],[x,0,z],[0,0,z]],faces=[[0,1,2,3]]);            
    polyhedron (points=[[0,0,0],[0,y,0],[x,y,0],[x,0,0]],faces=[[0,1,2,3]]);  
  }
}

module prisma(n, h, r1, r2) { //prisma de base regular
    
    //n: cantidad de caras del prisma, al cambiarlo cambia la figura creada
    //n=3: genera un prisma de base triangular
    //n=4: genera un prisma de base cuadrada
    //n=100: genera una aproximacion a un cilindro
    
    //r1: radio base inferior
    //r2: radio base superior
    //si n=100, r1!=0 y r2=0 se tiene un cono
    
    ang = (360)/n; //angulo
    
    function flatten(h) = [for (ang = h) for (b = ang) b];
    
    points = flatten([for(i=[0:n]) if(i==n) [[0,0,0],[0,0,h]]
            else [[r1*cos(ang*i), r1*sin(ang*i),0], //puntos de la base
                 [r2*cos(ang*i), r2*sin(ang*i),h]]
    ]); //puntos de la cara superior
            
    faces = flatten([ for(j=[0:n]) [[2*(j%n), 2*((j+1)%n), 2*n], //base
             [(2*(j%n))+1, (2*((j+1)%n))+1, (2*n)+1], //cara sup
             [2*(j%n), 2*((j+1)%n), (2*((j+1)%n))+1, (2*(j%n))+1]
        ]]); //manto
    
    polyhedron(points, faces);
}

//B-MO
rotate([0,0,180]) scale([5,5,5]) union(){
    color("MediumTurquoise") {
        difference(){
            translate([-2.5,-1.25,-3.5]) rectangulo(5,2.5,7);
            translate([-2,0.5,0]) rectangulo(4,1,3);
            translate([0.8,1.05,-2.8]) rectangulo(0.5,0.5,0.15);
            translate([1.5,1.05,-2.8]) rectangulo(0.5,0.5,0.15);
        }
    }
    color("Aquamarine") {
        translate([-2,1,0]) rectangulo(4,0.05,3);
    }
    color("Black"){
        translate([-1,1.1,1.5]) rotate([90,0,0]) prisma(100,0.1,0.2,0.2);
        translate([1,1.1,1.5]) rotate([90,0,0]) prisma(100,0.1,0.2,0.2);
        translate([-0.5,1.1,1]) rectangulo(1,0.05,0.1);
    }
    color("Navy"){
        translate([0,1.25,-0.5]) rectangulo(2,0.2,0.3);
        translate([0.8,1,-2.8]) rectangulo(0.5,0.2,0.15);
        translate([1.5,1,-2.8]) rectangulo(0.5,0.2,0.15);
    }
    color("MediumBlue"){
        translate([-1.5,1.5,-0.4]) rotate([90,0,0]) prisma(100,0.3,0.2,0.2);
    }
    color("Cyan"){
        translate([-0.75,1.5,-1.5]) rotate ([90,30,0]) prisma(3,0.3,0.4,0.4);
    }
    color("Lime"){
        translate([-1.75,1.5,-1.75]) rotate([90,0,0]) prisma(100,0.3,0.2,0.2);
    }
    color("Red"){
        translate([-1,1.5,-2.5]) rotate([90,0,0]) prisma(100,0.3,0.5,0.5);
    }
    color("Yellow"){
        translate([1.3,1.25,-2.3]) rectangulo(0.4,0.2,1);
        translate([1,1.25,-2]) rectangulo(1,0.2,0.4);
    }
    color("DarkTurquoise"){
        translate([-1.25,0,-5.5]) prisma(100,2,0.3,0.3);
        translate([1.25,0,-5.5]) prisma(100,2,0.3,0.3);
        translate([-3.8,0,-2.5]) rotate([0,30,0]) prisma(100,3,0.3,0.3);
        translate([3.8,0,-2.5]) rotate([0,-30,0]) prisma(100,3,0.3,0.3);
        translate([-1.25,0.3,-5.5]) intersection(){
            scale([0.02,0.02,0.02]) sphere(15);
            translate([-0.5,-0.5,0]) rectangulo(1,1,0.3);
        }
        translate([1.25,0.3,-5.5]) intersection(){
            scale([0.02,0.02,0.02]) sphere(15);
            translate([-0.5,-0.5,0]) rectangulo(1,1,0.3);
        }
       translate([-3.8,0,-2.5]) scale([0.02,0.02,0.02]) sphere(15);
       translate([3.8,0,-2.5]) scale([0.02,0.02,0.02]) sphere(15);
    }
}
