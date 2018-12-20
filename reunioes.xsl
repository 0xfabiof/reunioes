<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <!-- Definição de variáveis globais -->
    <xsl:variable name="mensagemErroContagemInferior">
        <xsl:message terminate="no"> Aviso: Número de votos menor que número de membros na lista -
            Faltam contabilizar votos. </xsl:message>
    </xsl:variable>

    <xsl:variable name="mensagemErroContagemSuperior">
        <xsl:message terminate="no"> Aviso: Número de votos maior que membros na lista - Foram
            contabilizados votos a mais. </xsl:message>
    </xsl:variable>

    <xsl:variable name="mensagemErroValidezID">
        <xsl:message terminate="no"> Aviso: Um ou mais membros que votaram não constam na lista de
            membros </xsl:message>
    </xsl:variable>
    
    <xsl:variable name="mensagemVotoSimultaneo">
        <xsl:message terminate="no"> Aviso: Um votante votou simultaneamente em duas opções incompatíveis (por exemplo favor e contra, etc.) </xsl:message>
    </xsl:variable>
    <!-- Definição de variáveis globais -->

    <!-- Definição de universos de chaves (Membros e Assuntos) -->
    <xsl:key name="refMembro" match="membro" use="@id"/>
    <xsl:key name="refAssunto" match="assunto" use="@assunto_id"/>
    <!-- Definição de universos de chaves (Membros e Assuntos) -->

    <!-- Definição de templates para mixed content (texto anotado)-->
    <xsl:template match="palavra_membro">
        <h5>
            <i>
                <xsl:text>O membro </xsl:text>
                <xsl:value-of select="@id"/>
                <xsl:text> tem a palavra: </xsl:text>
            </i>
        </h5>
        <p class="palavra_membro">
            <xsl:apply-templates/>
        </p>
        <h5>
            <i>
                <xsl:text>O membro </xsl:text>
                <xsl:value-of select="@id"/>
                <xsl:text> terminou o discurso. </xsl:text>
            </i>
        </h5>
    </xsl:template>
    <xsl:template match="seccao">
        <h2>
            <b>
                <u>Secção</u>
            </b>
        </h2>
        <p class="seccao">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="subseccao">
        <h3>
            <b>
                <u>Sub-secção</u>
            </b>
        </h3>
        <p class="subseccao">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="paragrafo">
        <h4>
            <b>
                <u>Parágrafo</u>
            </b>
        </h4>
        <p class="paragrafo">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="entrada_membro">
        <h4 class="entrada_membro">
            <xsl:text>O membro </xsl:text>
            <xsl:value-of select="@id"/>
            <xsl:text> entrou na Reunião</xsl:text>
        </h4>
    </xsl:template>
    <xsl:template match="saida_membro">
        <h4 class="saida_membro">
            <xsl:text>O membro </xsl:text>
            <xsl:value-of select="@id"/>
            <xsl:text> saiu da Reunião</xsl:text>
        </h4>
    </xsl:template>
    <!-- Definição de templates para mixed content (texto anotado)-->


    <!-- Transformação Principal -->
    <xsl:template match="/">
        <xsl:result-document method="html" href="reunioes.html">
            <html xmlns="http://www.w3.org/1999/xhtml">
                <head>
                    <link rel="stylesheet" href="reunioes.css"/>
                    <meta charset="UTF-8"/>
                    <title>Reuniões</title>

                    <!-- Lista de membros habituais ( -->
                    <h2 id="membrosHabituais">Membros Habituais</h2>
                    <table>
                        <xsl:for-each select="documento/membros_habituais/membro">
                            <td>
                                <ul>
                                    <li>
                                        <b>
                                            <xsl:text>Membro </xsl:text>
                                            <xsl:value-of select="@id"/>
                                        </b>
                                    </li>
                                    <li>
                                        <u>Nome:</u>
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of select="nome/proprio"/>
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of select="nome/apelido"/>
                                    </li>
                                    <li>
                                        <u>Título:</u>
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of select="titulo"/>
                                    </li>

                                </ul>
                            </td>
                        </xsl:for-each>
                    </table>
                    <hr/>
                    <!-- Lista de membros habituais ( -->


                    <!-- Índice - a rever-->
                    <nav class="indice">
                        <h1>Índice</h1>
                        <ul>
                            <xsl:for-each select="documento/reuniao">
                                <li>
                                    <a href="#{@id}">Reunião <xsl:value-of select="@id"/></a>
                                </li>
                            </xsl:for-each>
                        </ul>
                        <hr/>
                    </nav>
                    <!-- Índice - a rever-->

                </head>
                <body>

                    <!-- Transformações para cada reunião -->
                    <xsl:for-each select="documento/reuniao">
                        <div id="{@id}" class="reuniao">
                            <h1>Reunião <xsl:value-of select="@id"/></h1>
                            <ul class="metaReuniao1">
                                <li>
                                    <u>Data:</u>
                                    <xsl:text> </xsl:text>
                                </li>
                                <li>
                                    <u>Tipo:</u>
                                    <xsl:text> </xsl:text>
                                </li>


                                <li>
                                    <u>Presidente:</u>
                                    <xsl:text> </xsl:text>
                                </li>
                                <li>
                                    <u>Redator:</u>
                                    <xsl:text> </xsl:text>
                                </li>
                                <li>
                                    <br/>
                                    <u>Ordem de Trabalhos:</u>
                                </li>
                                <!-- Referências a chaves de membros (presidente e redator) e a chaves de assuntos (ordem de trabalhos) -->
                            </ul>
                            <ul class="metaReuniao2">
                                <li>
                                    <b>
                                        <xsl:value-of select="data"/>
                                    </b>
                                </li>
                                <li>
                                    <b>
                                        <xsl:value-of select="@tipo"/>
                                    </b>
                                </li>
                                <!-- Referências a chaves de membros (presidente e redator) e a chaves de assuntos (ordem de trabalhos) -->
                                <li>
                                    <b>
                                        <xsl:value-of
                                            select="key('refMembro', presidente/@id)/nome/proprio"/>
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of
                                            select="key('refMembro', presidente/@id)/nome/apelido"/>
                                    </b>
                                </li>
                                <li>
                                    <b>
                                        <xsl:value-of
                                            select="key('refMembro', redator/@id)/nome/proprio"/>
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of
                                            select="key('refMembro', redator/@id)/nome/apelido"/>
                                    </b>
                                </li>
                                <br/>
                                <xsl:for-each select="ordem_de_trabalho/item">
                                    <li>
                                        <u>Assunto:</u>
                                        <xsl:text> </xsl:text>
                                        <b>
                                            <xsl:value-of select="@item_id"/>
                                            <xsl:text> - </xsl:text>
                                            <xsl:value-of
                                                select="key('refAssunto', @item_id)/titulo"/>
                                        </b>
                                    </li>
                                </xsl:for-each>
                            </ul>

                            <!-- Lista de Membros de cada reunião -->
                            <h4>Membros na Reunião</h4>
                            <table class="tabelaMembros">
                                <tr>
                                    <!-- Lida com referências a membros habituais (acrescenta presença e justificação) -->
                                    <xsl:for-each select="membros/membro_habitual">
                                        <td>
                                            <ul>
                                                <li>
                                                  <b>
                                                  <xsl:text>Membro </xsl:text>
                                                  <xsl:value-of select="@id"/>
                                                  </b>
                                                </li>
                                                <li>
                                                  <u>Nome:</u>
                                                  <xsl:text> </xsl:text>
                                                  <xsl:value-of
                                                  select="key('refMembro', @id)/nome/proprio"/>
                                                  <xsl:text> </xsl:text>
                                                  <xsl:value-of
                                                  select="key('refMembro', @id)/nome/apelido"/>
                                                </li>
                                                <li>
                                                  <u>Título:</u>
                                                  <xsl:text> </xsl:text>
                                                  <xsl:value-of
                                                  select="key('refMembro', @id)/titulo"/>
                                                </li>
                                                <li>
                                                  <u>Presença:</u>
                                                  <xsl:if test="@presenca=true()">
                                                      <xs:text> Sim</xs:text>
                                                  </xsl:if>
                                                  <xsl:if test="@presenca=false()">
                                                      <xs:text> Não</xs:text>
                                                  </xsl:if>
                                                </li>
                                                <li>
                                                  <u>Justificação Ausência</u>
                                                  <xsl:text> </xsl:text>
                                                  <xsl:if test="@presenca = 'true'">
                                                  <xsl:text>N/A</xsl:text>
                                                  </xsl:if>
                                                  <xsl:if test="@presenca = 'false'">
                                                  <xsl:value-of select="justificacao_ausencia"/>
                                                  </xsl:if>
                                                </li>

                                            </ul>
                                        </td>
                                    </xsl:for-each>
                                    <!-- Lida com referências a membros habituais (acrescenta presença e justificação) -->

                                    <!-- Lida com a introdução de novos membros específicos a esta reunião -->
                                    <xsl:for-each select="membros/membro">
                                        <td>
                                            <ul>
                                                <li>
                                                  <b>
                                                  <xsl:text>Membro </xsl:text>
                                                  <xsl:value-of select="@id"/>
                                                  </b>
                                                  <li>
                                                  <u>Nome:</u>
                                                  <xsl:text> </xsl:text>
                                                  <xsl:value-of select="nome/proprio"/>
                                                  <xsl:text> </xsl:text>
                                                  <xsl:value-of select="nome/apelido"/>
                                                  </li>
                                                  <li>
                                                  <u>Título:</u>
                                                  <xsl:text> </xsl:text>
                                                  <xsl:value-of select="titulo"/>
                                                  </li>
                                                  <li>
                                                  <u>Presença</u>
                                                      <xsl:if test="@presenca=true()">
                                                          <xs:text> Sim</xs:text>
                                                      </xsl:if>
                                                      <xsl:if test="@presenca=false()">
                                                          <xs:text> Não</xs:text>
                                                      </xsl:if>
                                                  </li>
                                                  <li>
                                                  <u>Justificação Ausência</u>
                                                  <xsl:text> </xsl:text>
                                                  <xsl:if test="@presenca = 'true'">
                                                  <xsl:text>N/A</xsl:text>
                                                  </xsl:if>
                                                  <xsl:if test="@presenca = 'false'">
                                                  <xsl:value-of select="justificacao_ausencia"/>
                                                  </xsl:if>
                                                  </li>
                                                </li>
                                            </ul>
                                        </td>
                                    </xsl:for-each>
                                    <!-- Lida com a introdução de novos membros específicos a esta reunião -->
                                </tr>
                            </table>

                            <!-- Para cada assunto é produzido uma ligação a um novo output html com a discussão e votação do assunto -->
                            <xsl:for-each select="assuntos/assunto">
                                <div class="blocoAssunto">
                                    <h1>
                                        <xsl:text>Assunto: </xsl:text>
                                        <xsl:value-of select="@assunto_id"/>
                                    </h1>
                                    <h2>
                                        <xsl:text>Título: </xsl:text>
                                        <xsl:value-of select="titulo"/>
                                    </h2>
                                    <a href="{@assunto_id}.html" class="botaoAssunto">Discussão e
                                        Votação</a>
                                </div>
                                <xsl:result-document method="html" href="assunto_{@assunto_id}.html">
                                    <head>
                                        <link rel="stylesheet" href="assuntos.css"/>
                                        <meta charset="UTF-8"/>
                                        <title>Assunto <xsl:value-of select="@assunto_id"/></title>
                                        <h1>
                                            <xsl:text>Assunto: </xsl:text>
                                            <xsl:value-of select="@assunto_id"/>
                                        </h1>
                                        <h2>
                                            <xsl:text>Título: </xsl:text>
                                            <xsl:value-of select="titulo"/>
                                        </h2>
                                        <h2>
                                            <xsl:text>Discussão: </xsl:text>
                                        </h2>
                                    </head>
                                    <xsl:for-each select="discussao">

                                        <!-- Para cada discussao são aplicados os templates para mixed content definidos inicialmente -->
                                        <xsl:apply-templates select="palavra_membro"/>
                                        <xsl:apply-templates select="seccao"/>
                                        <xsl:apply-templates select="subseccao"/>
                                        <xsl:apply-templates select="paragrafo"/>
                                        <!-- Para cada discussao são aplicados os templates para mixed content definidos inicialmente -->

                                    </xsl:for-each>

                                    <!-- Testa para o tipo de votação num determinado assunto (moção ou alternativa) -->
                                    <xsl:if test="votacao/mocao">
                                        <h1>Tipo de votação: Moção</h1>
                                        <h2>
                                            <xsl:value-of select="votacao/mocao/texto"/>
                                        </h2>

                                        <!-- Identificação e contagem de votantes para o caso de moção -->
                                        <ul>
                                            <li>Membros a favor - Contagem: <xsl:value-of
                                                  select="count(votacao/mocao/membros_favor/membro_votante)"/>
                                                <ul>
                                                  <xsl:for-each
                                                  select="votacao/mocao/membros_favor/membro_votante">
                                                  <li>Membro <xsl:value-of select="@id"/></li>
                                                  </xsl:for-each>
                                                </ul>
                                            </li>
                                            <li>Membros contra - Contagem: <xsl:value-of
                                                  select="count(votacao/mocao/membros_contra/membro_votante)"/>
                                                <ul>
                                                  <xsl:for-each
                                                  select="votacao/mocao/membros_contra/membro_votante">
                                                  <li>Membro <xsl:value-of select="@id"/></li>
                                                  </xsl:for-each>
                                                </ul>
                                            </li>
                                            <li>Membros abstenção - Contagem: <xsl:value-of
                                                  select="count(votacao/mocao/membros_abstencao/membro_votante)"/>
                                                <ul>
                                                  <xsl:for-each
                                                  select="votacao/mocao/membros_abstencao/membro_votante">
                                                  <li>Membro <xsl:value-of select="@id"/></li>
                                                  </xsl:for-each>
                                                </ul>
                                            </li>
                                        </ul>
                                        <!-- Identificação e contagem de votantes para o caso de moção -->


                                        <!-- Lógica de contagem de vencedor -->
                                        <xsl:if
                                            test="count(votacao/mocao/membros_favor/membro_votante) = count(votacao/mocao/membros_contra/membro_votante)">
                                            <h1 class="mocaoempata">Moção empatada</h1>
                                        </xsl:if>
                                        <xsl:if
                                            test="count(votacao/mocao/membros_favor/membro_votante) &lt; count(votacao/mocao/membros_contra/membro_votante)">
                                            <h1 class="mocaochumba">Moção chumbada</h1>
                                        </xsl:if>
                                        <xsl:if
                                            test="count(votacao/mocao/membros_favor/membro_votante) &gt; count(votacao/mocao/membros_contra/membro_votante)">
                                            <h1 class="mocaopassa">Moção aprovada</h1>
                                        </xsl:if>
                                        <!-- Lógica de contagem de vencedor -->


                                        <!-- Valida se os membros a votar são os mesmos que estão inscritos -->
                                        <xsl:if
                                            test="not(votacao/mocao/membros_favor/membro_votante/@id = ../../membros/membro_habitual/@id or votacao/mocao/membros_favor/membro_votante/@id = ../../membros/membro/@id)">
                                            <xsl:copy-of select="$mensagemErroValidezID"/>
                                        </xsl:if>
                                        <xsl:if
                                            test="not(votacao/mocao/membros_contra/membro_votante/@id = ../../membros/membro_habitual/@id or votacao/mocao/membros_contra/membro_votante/@id = ../../membros/membro/@id)">
                                            <xsl:copy-of select="$mensagemErroValidezID"/>
                                        </xsl:if>
                                        <xsl:if
                                            test="not(votacao/mocao/membros_abstencao/membro_votante/@id = ../../membros/membro_habitual/@id or votacao/mocao/membros_abstencao/membro_votante/@id = ../../membros/membro/@id)">
                                            <xsl:copy-of select="$mensagemErroValidezID"/>
                                        </xsl:if>
                                        
                                        <!-- Valida se nenhum membro votou simultaneamente a favor e contra / a favor e abstencao / contra e abstencao -->
                                        <xsl:if test="votacao/mocao/membros_favor/membro_votante/@id = votacao/mocao/membros_contra/membro_votante/@id">
                                            <xsl:copy-of select="$mensagemVotoSimultaneo"/>
                                        </xsl:if>
                                        
                                        <xsl:if test="votacao/mocao/membros_favor/membro_votante/@id = votacao/mocao/membros_abstencao/membro_votante/@id">
                                            <xsl:copy-of select="$mensagemVotoSimultaneo"/>
                                        </xsl:if>
                                        
                                        <xsl:if test="votacao/mocao/membros_contra/membro_votante/@id = votacao/mocao/membros_abstencao/membro_votante/@id">
                                            <xsl:copy-of select="$mensagemVotoSimultaneo"/>
                                        </xsl:if>

                                        <!-- Valida se o número de votos é igual ao número de membros inscritos na reunião -->
                                        <xsl:if
                                            test="sum((count(votacao/mocao/membros_favor/membro_votante), count(votacao/mocao/membros_contra/membro_votante), count(votacao/mocao/membros_abstencao/membro_votante))) &lt; sum((count(../../membros/membro_habitual), count(../../membros/membro)))">
                                            <xsl:copy-of select="$mensagemErroContagemInferior"/>
                                        </xsl:if>

                                        <xsl:if
                                            test="sum((count(votacao/mocao/membros_favor/membro_votante), count(votacao/mocao/membros_contra/membro_votante), count(votacao/mocao/membros_abstencao/membro_votante))) &gt; sum((count(../../membros/membro_habitual), count(../../membros/membro)))">
                                            <xsl:copy-of select="$mensagemErroContagemSuperior"/>
                                        </xsl:if>

                                    </xsl:if>

                                    <!-- Testa para o tipo de votação num determinado assunto (moção ou alternativa) -->
                                    <xsl:if test="votacao/alternativa">
                                        <h1>Tipo de votação: Alternativa</h1>
                                        <h2>Opções ordenadas por número de votos</h2>

                                        <!-- Lógica de contagem e ordenação de votantes para cada alternativa - aponta o primeiro como vencedor -->
                                        <xsl:for-each select="votacao/alternativa/opcao">
                                            <xsl:sort
                                                select="count(membros_votantes/membro_votante)"
                                                data-type="number" order="descending"/>
                                            <h2>
                                                <xsl:value-of select="texto"/>
                                            </h2>
                                            <xsl:if test="position() = 1">
                                                <h3 class="opcaovencedora">Opção vencedora!</h3>
                                            </xsl:if>
                                            <ul>
                                                <xsl:for-each
                                                  select="membros_votantes/membro_votante">

                                                  <!-- Valida se os membros a votar são os mesmos que estão inscritos -->
                                                  <xsl:if
                                                  test="not(@id = ../../../../../../../membros/membro/@id or @id = ../../../../../../../membros/membro_habitual/@id)">
                                                  <xsl:copy-of select="$mensagemErroValidezID"/>
                                                  </xsl:if>
                                                  <!-- Valida se os membros a votar são os mesmos que estão inscritos -->

                                                  <li>Membro <xsl:value-of select="@id"/></li>
                                                </xsl:for-each>
                                            </ul>


                                        </xsl:for-each>
                                        <!-- Lógica de contagem e ordenação de votantes para cada alternativa - aponta o primeiro como vencedor -->



                                        <!-- Valida se o número de votos é igual ao número de membros inscritos na reunião -->
                                        <xsl:if
                                            test="count(votacao/alternativa/opcao/membros_votantes/membro_votante) &lt; sum((count(../../membros/membro_habitual), count(../../membros/membro)))">
                                            <xsl:copy-of select="$mensagemErroContagemInferior"/>
                                        </xsl:if>

                                        <xsl:if
                                            test="count(votacao/alternativa/opcao/membros_votantes/membro_votante) &gt; sum((count(../../membros/membro_habitual), count(../../membros/membro)))">
                                            <xsl:copy-of select="$mensagemErroContagemSuperior"/>
                                        </xsl:if>
                                        <!-- Valida se o número de votos é igual ao número de membros inscritos na reunião -->

                                    </xsl:if>

                                </xsl:result-document>
                            </xsl:for-each>
                            <!-- Para cada assunto é produzido uma ligação a um novo output html com a discussão e votação do assunto -->

                        </div>
                        <hr/>
                    </xsl:for-each>
                    <!-- Fim da transformação para cada reunião -->
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
