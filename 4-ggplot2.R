## ===========================================================================
## Study group: ggplot2 and its extension package (brief)
## Author: Tengku Hanis
## Date: 29-04-2021
## ===========================================================================

# Packages and data
library(tidyverse)
library(mlbench) # pima dataset
data("PimaIndiansDiabetes2")

# ggplot2 -----------------------------------------------------------------
## scatter plot
ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point() +
  geom_smooth() +
  facet_grid(~Species) +
  theme_bw()

## histogram
ggplot(data = iris, aes(x = Sepal.Length, fill = Species, color = Species)) +
  geom_histogram(alpha = 0.6) +
  theme_bw()

## kernel density plot (smoothed version of histogram)
ggplot(data = iris, aes(x = Sepal.Length, fill = Species)) +
  geom_density(alpha = 0.6) +
  theme_bw()

# ggstatplot --------------------------------------------------------------
## (https://github.com/IndrajeetPatil/ggstatsplot)
library(ggstatsplot)

## Correlogram
ggcorrmat(mtcars)

## Violin plot + boxplot
ggbetweenstats(data = iris %>% 
                 mutate(id = paste0(sample(letters, 150, replace = TRUE), 1:150)), #id for outliers
               x = Species,
               y = Sepal.Width,
               results.subtitle = FALSE,
               pairwise.comparisons = FALSE,
               #bf.message = FALSE,
               #ggsignif.args = list(textsize = 3.5, tip_length = 0.01),
               #p.adjust.method = "bonferroni",
               outlier.label.args = list(size = 4),
               outlier.tagging = TRUE,
               outlier.label = id,
               outlier.color = "red")

## Scatter plot + histogram
ggscatterstats(data = PimaIndiansDiabetes2,
               x = triceps,
               y = mass)

## Histogram with a normal distribution curve
gghistostats(data = PimaIndiansDiabetes2,
             x = age,
             results.subtitle = FALSE,
             normal.curve = TRUE,
             normal.curve.args = list(color = "red", size = 1))

grouped_gghistostats(data = PimaIndiansDiabetes2,
             x = age,
             grouping.var = diabetes,
             results.subtitle = FALSE,
             normal.curve = TRUE,
             normal.curve.args = list(color = "red", size = 1))

# ggpubr ------------------------------------------------------------------
## (https://rpkgs.datanovia.com/ggpubr/)
library(ggpubr)

## density plot
ggdensity(PimaIndiansDiabetes2, 
          x = "glucose", 
          add = "mean", 
          rug = TRUE,
          color = "diabetes", 
          fill = "diabetes")

## boxplot
pima_box <- ggboxplot(PimaIndiansDiabetes2, 
                      x = "diabetes", 
                      y = "glucose",
                      color = "diabetes", 
                      palette =c("#00AFBB", "#E7B800"),
                      add = "jitter")
pima_box
  # add p-value for comparison
pima_box + 
  stat_compare_means(comparisons = list(c("neg", "pos")),
                     method = "wilcox.test") # equivalent to mann-whitney  
                
# plotly ------------------------------------------------------------------
## (https://plotly.com/ggplot2/)
library(plotly)

## boxplot
p <- ggplot(data = iris, aes(x = Species, y = Sepal.Width, fill = Species)) +
  geom_boxplot() 
  
ggplotly(p) # ignore outlier in ggplot2

## scatter plot
p1 <- ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width, fill = Species)) +
  geom_point() +
  geom_smooth() 

ggplotly(p1)

# gganimate ---------------------------------------------------------------
# (https://gganimate.com/)
library(gganimate)

## Basic animate plot
sp <- ggplot(iris, aes(x = Petal.Width, y = Petal.Length)) + 
  geom_point() +
  theme_bw()
sp
sp + 
  transition_states(Species,
                    transition_length = 2,
                    state_length = 1)

## More complicated plot (copy paste from: https://gganimate.com/)
library(gapminder)

ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  # Here comes the gganimate specific bits
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')

