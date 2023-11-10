# Makefile

# 定义 Java 编译器
JAVAC = javac

# 定义编译选项
JAVAC_FLAGS =

# 定义所有的 Java 源文件和类文件
SOURCES = CouncilMember.java Learner.java M1Server.java M2Server.java M3Server.java M4Server.java M5Server.java M6Server.java M7Server.java M8Server.java M9Server.java Proposal.java
CLASSES = $(SOURCES:%.java=%.class)

# 定义 all 目标
all: $(CLASSES)

# 定义 clean 目标
clean:
	rm -f *.class

# 定义规则，生成每个类文件
%.class: %.java
	$(JAVAC) $(JAVAC_FLAGS) $<
