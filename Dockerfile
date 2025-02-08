# Use Rocker Rstuido imge
FROM rocker/rstudio:4.4.2

# Set Working Directory
WORKDIR /home/rstudio

# install renv package and remote package
RUN Rscript -e "install.packages('renv', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN Rscript -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"

# Copy all renv files into the container
COPY renv.lock ./renv.lock
COPY renv/ ./renv/
RUN Rscript -e 'renv::restore(confirm = FALSE)'

# install cowsay package
RUN Rscript -e "remotes::install_version('cowsay', version = '1.0.0')"

# install dplyr package
RUN Rscript -e 'install.packages("dplyr", repos="https://cran.rstudio.com")'

# Expose RStudio default port
EXPOSE 8787

# Copy the script 
COPY script.R script.R
# Run the script 
CMD ["Rscript", "script.R"] 