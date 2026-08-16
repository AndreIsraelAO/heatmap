### HEATMAP #####
library(pheatmap)
mydata <- read.csv2("mydata.csv", row.names = 1)
df.coldata <- read.csv2("coldata.csv", row.names = 1)

# Converter colunas para factor (necessário para levels() funcionar)
df.coldata$Tank <- as.factor(df.coldata$Tank)
df.coldata$Condition <- as.factor(df.coldata$Condition)

# Obter níveis das colunas fatoradas
Tanks <- levels(df.coldata$Tank)
Conditions <- levels(df.coldata$Condition)

# Gerar cores dinamicamente para Tanks (evita erro quando tanques mudam entre experimentos)
tank_colors <- setNames(gray.colors(length(Tanks), start = 0.9, end = 0.4), Tanks)

# Gerar cores dinamicamente para Conditions
condition_colors <- c(Control = "lightskyblue",
                      LowExposure = "royalblue1",
                      HighExposure = "navyblue")
# Filtrar apenas as condições presentes nos dados
condition_colors <- condition_colors[names(condition_colors) %in% Conditions]

ann_colors <- list(
  Condition = condition_colors,
  Tank = tank_colors
)

# Zscore normalized rows
pheatmap(mydata,
         angle_col = "0",
         border_color = NA, # "grey60" as default
         cluster_rows=TRUE,
         cluster_cols=TRUE,
         clustering_distance_rows = "maximum", # 'correlation', 'euclidean', 'maximum', 'manhattan', 'canberra', 'binary', 'minkowski'
         clustering_distance_cols = "maximum", # 'correlation', 'euclidean', 'maximum', 'manhattan', 'canberra', 'binary', 'minkowski'
         clustering_method = "average", # complete single average 
         scale = "row", #normalization of values row or col wise
         main = "z-score norm. rows",
         show_rownames=TRUE, 
         show_colnames = TRUE,
         color = gplots::greenred(75),
         annotation_col = df.coldata,
         annotation_colors = ann_colors)

# Mean rlog transformed counts
pheatmap(mydata,
         angle_col = "0",
         border_color = NA, # "grey60" as default
         cluster_rows=TRUE,
         cluster_cols=TRUE,
         clustering_distance_rows = "maximum", # 'correlation', 'euclidean', 'maximum', 'manhattan', 'canberra', 'binary', 'minkowski'
         clustering_distance_cols = "maximum", # 'correlation', 'euclidean', 'maximum', 'manhattan', 'canberra', 'binary', 'minkowski'
         clustering_method = "average", # complete single average 
         main = "rlog(mean counts)",
         show_rownames=TRUE, 
         show_colnames = TRUE,
         color = gplots::greenred(75),
         annotation_col = df.coldata,
         annotation_colors = ann_colors)

# -------------------------------------------------------------------
# PLOT BÁSICO (para lapidar depois)
# -------------------------------------------------------------------
# Versão simplificada só pra gerar o heatmap. 
# Dá pra melhorar depois: ajustar cores, ordem dos clusters, 
# títulos, rótulos, etc.

mat <- as.matrix(mydata)
pheatmap(
  mat,
  annotation_col = df.coldata[, c("Condition", "Tank")],
  annotation_colors = ann_colors,
  scale = "row"
)
