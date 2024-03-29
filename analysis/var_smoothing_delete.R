# 200bp

## All 6 mutation types

```{r echo=FALSE, message=FALSE, warning=FALSE,fig.height=5, fig.width=10}

data <- fread("/project/xinhe/xsun/mutation_rate/1.exp_obs_gnomad/data_processed/chr22/chr22.expobs.SNV.200bp.bed", fill = T)
data <- data[complete.cases(data$SNV_exp),]
data$SNV_obs[data$SNV_obs ==0] <- 0.5

data$Mb <- data$start / 1000000

data$randeff <- data$SNV_obs/data$SNV_exp
data$log_randeff <- log(data$randeff)

smooth <- smash.gaus(data$log_randeff,joint = T)
data$var <- smooth$var.res
data$randeff_sm_diff_var <- smooth$mu.res

const_var <- sd_estimate_gasser_etal(data$log_randeff)
print(paste0("the current constant variance is ", const_var ))

ggplot(data, aes(x = Mb, y = var)) +
  geom_point(size=0.2) +
  labs(x = "Genomic position(MB)", y = "Variance") +
  geom_line(aes(x = data$Mb, y = const_var), color = "red",size=0.2) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using default setting:")
ggplot(data, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = randeff_sm_diff_var), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using constant variance:")
data$lgre_const <- smash.gaus(data$log_randeff,sigma = const_var)
ggplot(data, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = lgre_const), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *3 = ",const_var*3, "we have"))
data$lgre_const_larger <- smash.gaus(data$log_randeff,sigma = const_var*3)
ggplot(data, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *8 = ",const_var*8, "we have"))
data$lgre_const_larger2 <- smash.gaus(data$log_randeff,sigma = const_var*8)
ggplot(data, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/3 = ",const_var/3, "we have"))
data$lgre_const_smaller <- smash.gaus(data$log_randeff,sigma = const_var/3)
ggplot(data, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/8 = ",const_var/8, "we have"))
data$lgre_const_smaller2 <- smash.gaus(data$log_randeff,sigma = const_var/8)
ggplot(data, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

data_save <- data

```



### Hot spots (22.5Mb - 23.5Mb)

```{r echo=FALSE, message=FALSE, warning=FALSE,fig.height=5, fig.width=10}

data <- data_save
data_cut <- data[data$Mb >22.5 & data$Mb <23.5,]

print("the variance in current window")

ggplot(data_cut, aes(x = Mb, y = var)) +
  geom_point(size=0.2) +
  labs(x = "Genomic position(MB)", y = "Variance") +
  geom_line(aes(x = data_cut$Mb, y = const_var), color = "red",size=0.2) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using default setting:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = randeff_sm_diff_var), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using constant variance:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = lgre_const), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *3 = ",const_var*3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *8 = ",const_var*8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/3 = ",const_var/3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/8 = ",const_var/8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


```




### Cold spots (21Mb - 22Mb)

```{r echo=FALSE, message=FALSE, warning=FALSE,fig.height=5, fig.width=10}

data <- data_save
data_cut <- data[data$Mb >21 & data$Mb <22,]

print("the variance in current window")

ggplot(data_cut, aes(x = Mb, y = var)) +
  geom_point(size=0.2) +
  labs(x = "Genomic position(MB)", y = "Variance") +
  geom_line(aes(x = data_cut$Mb, y = const_var), color = "red",size=0.2) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using default setting:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = randeff_sm_diff_var), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using constant variance:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = lgre_const), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *3 = ",const_var*3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *8 = ",const_var*8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/3 = ",const_var/3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/8 = ",const_var/8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


```




### Cold spots (18Mb - 19Mb)

```{r echo=FALSE, message=FALSE, warning=FALSE,fig.height=5, fig.width=10}

data <- data_save
data_cut <- data[data$Mb >18 & data$Mb <19,]

print("the variance in current window")

ggplot(data_cut, aes(x = Mb, y = var)) +
  geom_point(size=0.2) +
  labs(x = "Genomic position(MB)", y = "Variance") +
  geom_line(aes(x = data_cut$Mb, y = const_var), color = "red",size=0.2) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using default setting:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = randeff_sm_diff_var), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using constant variance:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = lgre_const), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *3 = ",const_var*3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *8 = ",const_var*8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/3 = ",const_var/3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/8 = ",const_var/8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


```




### typical regions (25Mb - 26Mb)

```{r echo=FALSE, message=FALSE, warning=FALSE,fig.height=5, fig.width=10}

data <- data_save
data_cut <- data[data$Mb >25 & data$Mb <26,]

print("the variance in current window")

ggplot(data_cut, aes(x = Mb, y = var)) +
  geom_point(size=0.2) +
  labs(x = "Genomic position(MB)", y = "Variance") +
  geom_line(aes(x = data_cut$Mb, y = const_var), color = "red",size=0.2) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using default setting:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = randeff_sm_diff_var), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using constant variance:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = lgre_const), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *3 = ",const_var*3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *8 = ",const_var*8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/3 = ",const_var/3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/8 = ",const_var/8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


```




### typical regions (31Mb - 32Mb)

```{r echo=FALSE, message=FALSE, warning=FALSE,fig.height=5, fig.width=10}

data <- data_save
data_cut <- data[data$Mb >31 & data$Mb <32,]

print("the variance in current window")

ggplot(data_cut, aes(x = Mb, y = var)) +
  geom_point(size=0.2) +
  labs(x = "Genomic position(MB)", y = "Variance") +
  geom_line(aes(x = data_cut$Mb, y = const_var), color = "red",size=0.2) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using default setting:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = randeff_sm_diff_var), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using constant variance:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = lgre_const), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *3 = ",const_var*3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *8 = ",const_var*8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/3 = ",const_var/3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/8 = ",const_var/8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


```





# 1kb

## All 6 mutation types

```{r echo=FALSE, message=FALSE, warning=FALSE,fig.height=5, fig.width=10}

data <- fread("/project/xinhe/xsun/mutation_rate/1.exp_obs_gnomad/data_processed/chr22/chr22.expobs.SNV.1kb.bed", fill = T)
data <- data[complete.cases(data$SNV_exp),]
data$SNV_obs[data$SNV_obs ==0] <- 0.5

data$Mb <- data$start / 1000000

data$randeff <- data$SNV_obs/data$SNV_exp
data$log_randeff <- log(data$randeff)

smooth <- smash.gaus(data$log_randeff,joint = T)
data$var <- smooth$var.res
data$randeff_sm_diff_var <- smooth$mu.res

const_var <- sd_estimate_gasser_etal(data$log_randeff)
print(paste0("the current constant variance is ", const_var ))

ggplot(data, aes(x = Mb, y = var)) +
  geom_point(size=0.2) +
  labs(x = "Genomic position(MB)", y = "Variance") +
  geom_line(aes(x = data$Mb, y = const_var), color = "red",size=0.2) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using default setting:")
ggplot(data, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = randeff_sm_diff_var), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using constant variance:")
data$lgre_const <- smash.gaus(data$log_randeff,sigma = const_var)
ggplot(data, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = lgre_const), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *3 = ",const_var*3, "we have"))
data$lgre_const_larger <- smash.gaus(data$log_randeff,sigma = const_var*3)
ggplot(data, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *8 = ",const_var*8, "we have"))
data$lgre_const_larger2 <- smash.gaus(data$log_randeff,sigma = const_var*8)
ggplot(data, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/3 = ",const_var/3, "we have"))
data$lgre_const_smaller <- smash.gaus(data$log_randeff,sigma = const_var/3)
ggplot(data, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/8 = ",const_var/8, "we have"))
data$lgre_const_smaller2 <- smash.gaus(data$log_randeff,sigma = const_var/8)
ggplot(data, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

data_save <- data

```



### Hot spots (22.5Mb - 23.5Mb)

```{r echo=FALSE, message=FALSE, warning=FALSE,fig.height=5, fig.width=10}

data <- data_save
data_cut <- data[data$Mb >22.5 & data$Mb <23.5,]

print("the variance in current window")

ggplot(data_cut, aes(x = Mb, y = var)) +
  geom_point(size=0.2) +
  labs(x = "Genomic position(MB)", y = "Variance") +
  geom_line(aes(x = data_cut$Mb, y = const_var), color = "red",size=0.2) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using default setting:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = randeff_sm_diff_var), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using constant variance:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = lgre_const), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *3 = ",const_var*3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *8 = ",const_var*8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/3 = ",const_var/3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/8 = ",const_var/8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


```




### Cold spots (21Mb - 22Mb)

```{r echo=FALSE, message=FALSE, warning=FALSE,fig.height=5, fig.width=10}

data <- data_save
data_cut <- data[data$Mb >21 & data$Mb <22,]

print("the variance in current window")

ggplot(data_cut, aes(x = Mb, y = var)) +
  geom_point(size=0.2) +
  labs(x = "Genomic position(MB)", y = "Variance") +
  geom_line(aes(x = data_cut$Mb, y = const_var), color = "red",size=0.2) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using default setting:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = randeff_sm_diff_var), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using constant variance:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = lgre_const), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *3 = ",const_var*3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *8 = ",const_var*8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/3 = ",const_var/3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/8 = ",const_var/8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


```




### Cold spots (18Mb - 19Mb)

```{r echo=FALSE, message=FALSE, warning=FALSE,fig.height=5, fig.width=10}

data <- data_save
data_cut <- data[data$Mb >18 & data$Mb <19,]

print("the variance in current window")

ggplot(data_cut, aes(x = Mb, y = var)) +
  geom_point(size=0.2) +
  labs(x = "Genomic position(MB)", y = "Variance") +
  geom_line(aes(x = data_cut$Mb, y = const_var), color = "red",size=0.2) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using default setting:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = randeff_sm_diff_var), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using constant variance:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = lgre_const), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *3 = ",const_var*3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *8 = ",const_var*8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/3 = ",const_var/3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/8 = ",const_var/8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


```




### typical regions (25Mb - 26Mb)

```{r echo=FALSE, message=FALSE, warning=FALSE,fig.height=5, fig.width=10}

data <- data_save
data_cut <- data[data$Mb >25 & data$Mb <26,]

print("the variance in current window")

ggplot(data_cut, aes(x = Mb, y = var)) +
  geom_point(size=0.2) +
  labs(x = "Genomic position(MB)", y = "Variance") +
  geom_line(aes(x = data_cut$Mb, y = const_var), color = "red",size=0.2) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using default setting:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = randeff_sm_diff_var), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using constant variance:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = lgre_const), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *3 = ",const_var*3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *8 = ",const_var*8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/3 = ",const_var/3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/8 = ",const_var/8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


```




### typical regions (31Mb - 32Mb)

```{r echo=FALSE, message=FALSE, warning=FALSE,fig.height=5, fig.width=10}

data <- data_save
data_cut <- data[data$Mb >31 & data$Mb <32,]

print("the variance in current window")

ggplot(data_cut, aes(x = Mb, y = var)) +
  geom_point(size=0.2) +
  labs(x = "Genomic position(MB)", y = "Variance") +
  geom_line(aes(x = data_cut$Mb, y = const_var), color = "red",size=0.2) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using default setting:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = randeff_sm_diff_var), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print("the log(random effect) using constant variance:")
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y = lgre_const), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *3 = ",const_var*3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


print(paste0("If we set the variance larger, as current constant variance *8 = ",const_var*8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_larger2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/3 = ",const_var/3, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

print(paste0("If we set the variance smaller, as current constant variance *1/8 = ",const_var/8, "we have"))
ggplot(data_cut, aes(x = Mb, y = log_randeff)) +
  geom_point(size=0.2) +
  geom_line(aes(x = Mb, y =lgre_const_smaller2), color = "red",size=0.2) +
  labs(x = "Genomic position(MB)", y = "log(Random Effect)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


```



