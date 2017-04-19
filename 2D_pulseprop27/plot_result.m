function plot_result()

addpath('/export111/work/jg1916/SDF/Matlab/');
c=1e8;
epsilon0=8.854e-12; 
e=1.6e-19;  
timern=datestr(now,'YYYY_mm_ddTHH-MM-SS');
mkdir('output')
mkdir(['output' filesep timern]);

dl=dir('*.sdf');
filenames={dl(:).name};
fig=figure;
j=1;
for i=5:50
   filetmp=filenames{i};
   data=GetDataSDF(filetmp);
   timestr=sprintf('Timestep: %.0f',data.time*1e15);
   ex=data.Electric_Field.Ex.data';
   ey=data.Electric_Field.Ey.data';
   ez=data.Electric_Field.Ez.data';
   x=data.Grid.Grid.x;
   y=data.Grid.Grid.y;
   x(end)=[];
   y(end)=[];
   figure(fig);
   subplot(2,1,1)
   imagesc(x,y,0.5*epsilon0*c.*ey.^2)
   cm=colormap('cool');
   cm(1,:)=[1 1 1 ];
   colormap(cm)
   set(gca,'YDir','normal')
   
   title(timestr)
   colorbar;
   I(j)=max(max(0.5*epsilon0*c.*ey.^2));

   subplot(2,1,2)
   plot(1:j,I)

   %% gaussian beam block
   micron=1e-6;
   lambda0 = .8 * micron;
 I0 = 1e15 * 1e4 ;

 waifwhm = 5*micron;
  wai = waifwhm/(sqrt(2.0*log(2.0)));
  rayleigh_range = pi*wai^2/lambda0;
  xfoc=-20*micron+data.time*c;
  wz = wai * sqrt(1 + (xfoc/rayleigh_range)^2);
  Ientry = I0*wai/wz;
   Igauss(j)=Ientry;
   hold on
   plot(1:j,Igauss)
   Itmp=ones([1 j]).*I0;
   plot(1:j,Itmp,'r')
   j=j+1;
   clear data
   print(fig,['output' filesep timern filesep filetmp(1:end-4)],'-dpng');
   fprintf('%s\n',timestr)
end

close(fig)
