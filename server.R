library(shiny)
library(ggplot2)
library(plotly)
library(latex2exp)
load("loss_func2d.Rdata")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  tex <- function(x){
    structure(x, class="LaTeX")
  }
  
  output$two_d <- renderPlotly({
    
    s = input$s
    square <- data.frame(
      x = c(s, 0, -s, 0),
      y = c(0, s, 0, -s))
    
    ggplotly(ggplot(data = loss_function)+
      geom_raster(aes(beta0, beta1, fill = loss_inverse))+
      geom_vline(xintercept = 0) + 
      geom_hline(yintercept = 0) +
      geom_polygon(data=square,
                   aes(x = x, y = y), fill= "deepskyblue", alpha = 0.4)+
      scale_fill_gradientn(colours=c("white","firebrick"))+
      geom_contour(data = loss_function, aes(beta0, beta1, z=loss_inverse), colour="darkseagreen") +  
      xlim(-20,20) + ylim(-20,20) + 
      coord_fixed()+
      theme(panel.background = element_rect(fill = NA)))
  })
  
  output$thr_d <- renderPlotly({
    ind = which(abs(loss_function$beta0)+abs(loss_function$beta1) <= input$s)
    x<-list(title="beta_0")
    y<-list(title="beta_1")
    z<-list(title="loss function")
    plot_ly(x = loss_function$beta0,
            y = loss_function$beta1,
            z = loss_function$loss,
            type="mesh3d",
            color=c(255,255,255)) %>%
      add_trace(x=loss_function$beta0[ind],
                y=loss_function$beta1[ind],
                z=seq(0,0,length.out=length(ind)),
                type="mesh3d") %>%
      add_trace(x=loss_function$beta0[ind],
                y=loss_function$beta1[ind],
                z=loss_function$loss[ind],
                type="mesh3d") %>%
      add_trace(x=4.696704,
                y=5.802296,
                z=2.346125,
                type="scatter3d",
                mode="markders",
                marker=list(size=2)) %>%
      layout(scene=list(xaxis=x,
                        yaxis=y,
                        zaxis=z))
      

  })
 
})