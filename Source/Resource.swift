//  Resource
//  Formated By swiftformat
//  Created by LawLincoln 
//  Copyright © 2016年 LawLincoln. All rights reserved.
public protocol FullPathProvidable { var fullPath: String { get } }

public enum Resource: String, FullPathProvidable {
    
    case SyntaxHighlightingJson = "/Resource/syntax_highlighting.json"
    
    public enum Extensions: String, FullPathProvidable {
        
        case ShowInformationCss = "/Resource/Extensions/show-information.css"
        
        case TasklistJs = "/Resource/Extensions/tasklist.js"
    }
    
    public enum Flowchartsequence: String, FullPathProvidable {
        
        case FlowchartInitJs = "/Resource/FlowChartSequence/flowchart.init.js"
        
        case FlowchartMinJs = "/Resource/FlowChartSequence/flowchart.min.js"
        
        case RaphaelMinJs = "/Resource/FlowChartSequence/raphael.min.js"
        
        case SequenceDiagramInitJs = "/Resource/FlowChartSequence/sequence-diagram-init.js"
        
        case SequenceDiagramMinJs = "/Resource/FlowChartSequence/sequence-diagram-min.js"
        
        case UnderscoreMinJs = "/Resource/FlowChartSequence/underscore-min.js"
    }
    
    public enum Mathjax: String, FullPathProvidable {
        
        case InitJs = "/Resource/MathJax/init.js"
    }
    
    public enum Prism: String, FullPathProvidable {
        
        case ComponentsJs = "/Resource/prism/components.js"
        
        public enum Components: String, FullPathProvidable {
            
            case PrismAbapJs = "/Resource/prism/components/prism-abap.js"
            
            case PrismAbapMinJs = "/Resource/prism/components/prism-abap.min.js"
            
            case PrismActionscriptJs = "/Resource/prism/components/prism-actionscript.js"
            
            case PrismActionscriptMinJs = "/Resource/prism/components/prism-actionscript.min.js"
            
            case PrismAdaJs = "/Resource/prism/components/prism-ada.js"
            
            case PrismAdaMinJs = "/Resource/prism/components/prism-ada.min.js"
            
            case PrismApacheconfJs = "/Resource/prism/components/prism-apacheconf.js"
            
            case PrismApacheconfMinJs = "/Resource/prism/components/prism-apacheconf.min.js"
            
            case PrismAplJs = "/Resource/prism/components/prism-apl.js"
            
            case PrismAplMinJs = "/Resource/prism/components/prism-apl.min.js"
            
            case PrismApplescriptJs = "/Resource/prism/components/prism-applescript.js"
            
            case PrismApplescriptMinJs = "/Resource/prism/components/prism-applescript.min.js"
            
            case PrismAsciidocJs = "/Resource/prism/components/prism-asciidoc.js"
            
            case PrismAsciidocMinJs = "/Resource/prism/components/prism-asciidoc.min.js"
            
            case PrismAspnetJs = "/Resource/prism/components/prism-aspnet.js"
            
            case PrismAspnetMinJs = "/Resource/prism/components/prism-aspnet.min.js"
            
            case PrismAutohotkeyJs = "/Resource/prism/components/prism-autohotkey.js"
            
            case PrismAutohotkeyMinJs = "/Resource/prism/components/prism-autohotkey.min.js"
            
            case PrismAutoitJs = "/Resource/prism/components/prism-autoit.js"
            
            case PrismAutoitMinJs = "/Resource/prism/components/prism-autoit.min.js"
            
            case PrismBashJs = "/Resource/prism/components/prism-bash.js"
            
            case PrismBashMinJs = "/Resource/prism/components/prism-bash.min.js"
            
            case PrismBasicJs = "/Resource/prism/components/prism-basic.js"
            
            case PrismBasicMinJs = "/Resource/prism/components/prism-basic.min.js"
            
            case PrismBatchJs = "/Resource/prism/components/prism-batch.js"
            
            case PrismBatchMinJs = "/Resource/prism/components/prism-batch.min.js"
            
            case PrismBisonJs = "/Resource/prism/components/prism-bison.js"
            
            case PrismBisonMinJs = "/Resource/prism/components/prism-bison.min.js"
            
            case PrismBrainfuckJs = "/Resource/prism/components/prism-brainfuck.js"
            
            case PrismBrainfuckMinJs = "/Resource/prism/components/prism-brainfuck.min.js"
            
            case PrismBroJs = "/Resource/prism/components/prism-bro.js"
            
            case PrismBroMinJs = "/Resource/prism/components/prism-bro.min.js"
            
            case PrismCJs = "/Resource/prism/components/prism-c.js"
            
            case PrismCMinJs = "/Resource/prism/components/prism-c.min.js"
            
            case PrismClikeJs = "/Resource/prism/components/prism-clike.js"
            
            case PrismClikeMinJs = "/Resource/prism/components/prism-clike.min.js"
            
            case PrismCoffeescriptJs = "/Resource/prism/components/prism-coffeescript.js"
            
            case PrismCoffeescriptMinJs = "/Resource/prism/components/prism-coffeescript.min.js"
            
            case PrismCoreJs = "/Resource/prism/components/prism-core.js"
            
            case PrismCoreMinJs = "/Resource/prism/components/prism-core.min.js"
            
            case PrismCppJs = "/Resource/prism/components/prism-cpp.js"
            
            case PrismCppMinJs = "/Resource/prism/components/prism-cpp.min.js"
            
            case PrismCrystalJs = "/Resource/prism/components/prism-crystal.js"
            
            case PrismCrystalMinJs = "/Resource/prism/components/prism-crystal.min.js"
            
            case PrismCsharpJs = "/Resource/prism/components/prism-csharp.js"
            
            case PrismCsharpMinJs = "/Resource/prism/components/prism-csharp.min.js"
            
            case PrismCssExtrasJs = "/Resource/prism/components/prism-css-extras.js"
            
            case PrismCssExtrasMinJs = "/Resource/prism/components/prism-css-extras.min.js"
            
            case PrismCssJs = "/Resource/prism/components/prism-css.js"
            
            case PrismCssMinJs = "/Resource/prism/components/prism-css.min.js"
            
            case PrismDJs = "/Resource/prism/components/prism-d.js"
            
            case PrismDMinJs = "/Resource/prism/components/prism-d.min.js"
            
            case PrismDartJs = "/Resource/prism/components/prism-dart.js"
            
            case PrismDartMinJs = "/Resource/prism/components/prism-dart.min.js"
            
            case PrismDiffJs = "/Resource/prism/components/prism-diff.js"
            
            case PrismDiffMinJs = "/Resource/prism/components/prism-diff.min.js"
            
            case PrismDockerJs = "/Resource/prism/components/prism-docker.js"
            
            case PrismDockerMinJs = "/Resource/prism/components/prism-docker.min.js"
            
            case PrismEiffelJs = "/Resource/prism/components/prism-eiffel.js"
            
            case PrismEiffelMinJs = "/Resource/prism/components/prism-eiffel.min.js"
            
            case PrismElixirJs = "/Resource/prism/components/prism-elixir.js"
            
            case PrismElixirMinJs = "/Resource/prism/components/prism-elixir.min.js"
            
            case PrismErlangJs = "/Resource/prism/components/prism-erlang.js"
            
            case PrismErlangMinJs = "/Resource/prism/components/prism-erlang.min.js"
            
            case PrismFortranJs = "/Resource/prism/components/prism-fortran.js"
            
            case PrismFortranMinJs = "/Resource/prism/components/prism-fortran.min.js"
            
            case PrismFsharpJs = "/Resource/prism/components/prism-fsharp.js"
            
            case PrismFsharpMinJs = "/Resource/prism/components/prism-fsharp.min.js"
            
            case PrismGherkinJs = "/Resource/prism/components/prism-gherkin.js"
            
            case PrismGherkinMinJs = "/Resource/prism/components/prism-gherkin.min.js"
            
            case PrismGitJs = "/Resource/prism/components/prism-git.js"
            
            case PrismGitMinJs = "/Resource/prism/components/prism-git.min.js"
            
            case PrismGlslJs = "/Resource/prism/components/prism-glsl.js"
            
            case PrismGlslMinJs = "/Resource/prism/components/prism-glsl.min.js"
            
            case PrismGoJs = "/Resource/prism/components/prism-go.js"
            
            case PrismGoMinJs = "/Resource/prism/components/prism-go.min.js"
            
            case PrismGraphqlJs = "/Resource/prism/components/prism-graphql.js"
            
            case PrismGraphqlMinJs = "/Resource/prism/components/prism-graphql.min.js"
            
            case PrismGroovyJs = "/Resource/prism/components/prism-groovy.js"
            
            case PrismGroovyMinJs = "/Resource/prism/components/prism-groovy.min.js"
            
            case PrismHamlJs = "/Resource/prism/components/prism-haml.js"
            
            case PrismHamlMinJs = "/Resource/prism/components/prism-haml.min.js"
            
            case PrismHandlebarsJs = "/Resource/prism/components/prism-handlebars.js"
            
            case PrismHandlebarsMinJs = "/Resource/prism/components/prism-handlebars.min.js"
            
            case PrismHaskellJs = "/Resource/prism/components/prism-haskell.js"
            
            case PrismHaskellMinJs = "/Resource/prism/components/prism-haskell.min.js"
            
            case PrismHaxeJs = "/Resource/prism/components/prism-haxe.js"
            
            case PrismHaxeMinJs = "/Resource/prism/components/prism-haxe.min.js"
            
            case PrismHttpJs = "/Resource/prism/components/prism-http.js"
            
            case PrismHttpMinJs = "/Resource/prism/components/prism-http.min.js"
            
            case PrismIconJs = "/Resource/prism/components/prism-icon.js"
            
            case PrismIconMinJs = "/Resource/prism/components/prism-icon.min.js"
            
            case PrismInform7Js = "/Resource/prism/components/prism-inform7.js"
            
            case PrismInform7MinJs = "/Resource/prism/components/prism-inform7.min.js"
            
            case PrismIniJs = "/Resource/prism/components/prism-ini.js"
            
            case PrismIniMinJs = "/Resource/prism/components/prism-ini.min.js"
            
            case PrismJJs = "/Resource/prism/components/prism-j.js"
            
            case PrismJMinJs = "/Resource/prism/components/prism-j.min.js"
            
            case PrismJadeJs = "/Resource/prism/components/prism-jade.js"
            
            case PrismJadeMinJs = "/Resource/prism/components/prism-jade.min.js"
            
            case PrismJavaJs = "/Resource/prism/components/prism-java.js"
            
            case PrismJavaMinJs = "/Resource/prism/components/prism-java.min.js"
            
            case PrismJavascriptJs = "/Resource/prism/components/prism-javascript.js"
            
            case PrismJavascriptMinJs = "/Resource/prism/components/prism-javascript.min.js"
            
            case PrismJsonJs = "/Resource/prism/components/prism-json.js"
            
            case PrismJsonMinJs = "/Resource/prism/components/prism-json.min.js"
            
            case PrismJsxJs = "/Resource/prism/components/prism-jsx.js"
            
            case PrismJsxMinJs = "/Resource/prism/components/prism-jsx.min.js"
            
            case PrismJuliaJs = "/Resource/prism/components/prism-julia.js"
            
            case PrismJuliaMinJs = "/Resource/prism/components/prism-julia.min.js"
            
            case PrismKeymanJs = "/Resource/prism/components/prism-keyman.js"
            
            case PrismKeymanMinJs = "/Resource/prism/components/prism-keyman.min.js"
            
            case PrismKotlinJs = "/Resource/prism/components/prism-kotlin.js"
            
            case PrismKotlinMinJs = "/Resource/prism/components/prism-kotlin.min.js"
            
            case PrismLatexJs = "/Resource/prism/components/prism-latex.js"
            
            case PrismLatexMinJs = "/Resource/prism/components/prism-latex.min.js"
            
            case PrismLessJs = "/Resource/prism/components/prism-less.js"
            
            case PrismLessMinJs = "/Resource/prism/components/prism-less.min.js"
            
            case PrismLivescriptJs = "/Resource/prism/components/prism-livescript.js"
            
            case PrismLivescriptMinJs = "/Resource/prism/components/prism-livescript.min.js"
            
            case PrismLolcodeJs = "/Resource/prism/components/prism-lolcode.js"
            
            case PrismLolcodeMinJs = "/Resource/prism/components/prism-lolcode.min.js"
            
            case PrismLuaJs = "/Resource/prism/components/prism-lua.js"
            
            case PrismLuaMinJs = "/Resource/prism/components/prism-lua.min.js"
            
            case PrismMakefileJs = "/Resource/prism/components/prism-makefile.js"
            
            case PrismMakefileMinJs = "/Resource/prism/components/prism-makefile.min.js"
            
            case PrismMarkdownJs = "/Resource/prism/components/prism-markdown.js"
            
            case PrismMarkdownMinJs = "/Resource/prism/components/prism-markdown.min.js"
            
            case PrismMarkupJs = "/Resource/prism/components/prism-markup.js"
            
            case PrismMarkupMinJs = "/Resource/prism/components/prism-markup.min.js"
            
            case PrismMatlabJs = "/Resource/prism/components/prism-matlab.js"
            
            case PrismMatlabMinJs = "/Resource/prism/components/prism-matlab.min.js"
            
            case PrismMelJs = "/Resource/prism/components/prism-mel.js"
            
            case PrismMelMinJs = "/Resource/prism/components/prism-mel.min.js"
            
            case PrismMizarJs = "/Resource/prism/components/prism-mizar.js"
            
            case PrismMizarMinJs = "/Resource/prism/components/prism-mizar.min.js"
            
            case PrismMonkeyJs = "/Resource/prism/components/prism-monkey.js"
            
            case PrismMonkeyMinJs = "/Resource/prism/components/prism-monkey.min.js"
            
            case PrismNasmJs = "/Resource/prism/components/prism-nasm.js"
            
            case PrismNasmMinJs = "/Resource/prism/components/prism-nasm.min.js"
            
            case PrismNginxJs = "/Resource/prism/components/prism-nginx.js"
            
            case PrismNginxMinJs = "/Resource/prism/components/prism-nginx.min.js"
            
            case PrismNimJs = "/Resource/prism/components/prism-nim.js"
            
            case PrismNimMinJs = "/Resource/prism/components/prism-nim.min.js"
            
            case PrismNixJs = "/Resource/prism/components/prism-nix.js"
            
            case PrismNixMinJs = "/Resource/prism/components/prism-nix.min.js"
            
            case PrismNsisJs = "/Resource/prism/components/prism-nsis.js"
            
            case PrismNsisMinJs = "/Resource/prism/components/prism-nsis.min.js"
            
            case PrismObjectivecJs = "/Resource/prism/components/prism-objectivec.js"
            
            case PrismObjectivecMinJs = "/Resource/prism/components/prism-objectivec.min.js"
            
            case PrismOcamlJs = "/Resource/prism/components/prism-ocaml.js"
            
            case PrismOcamlMinJs = "/Resource/prism/components/prism-ocaml.min.js"
            
            case PrismOzJs = "/Resource/prism/components/prism-oz.js"
            
            case PrismOzMinJs = "/Resource/prism/components/prism-oz.min.js"
            
            case PrismParigpJs = "/Resource/prism/components/prism-parigp.js"
            
            case PrismParigpMinJs = "/Resource/prism/components/prism-parigp.min.js"
            
            case PrismParserJs = "/Resource/prism/components/prism-parser.js"
            
            case PrismParserMinJs = "/Resource/prism/components/prism-parser.min.js"
            
            case PrismPascalJs = "/Resource/prism/components/prism-pascal.js"
            
            case PrismPascalMinJs = "/Resource/prism/components/prism-pascal.min.js"
            
            case PrismPerlJs = "/Resource/prism/components/prism-perl.js"
            
            case PrismPerlMinJs = "/Resource/prism/components/prism-perl.min.js"
            
            case PrismPhpExtrasJs = "/Resource/prism/components/prism-php-extras.js"
            
            case PrismPhpExtrasMinJs = "/Resource/prism/components/prism-php-extras.min.js"
            
            case PrismPhpJs = "/Resource/prism/components/prism-php.js"
            
            case PrismPhpMinJs = "/Resource/prism/components/prism-php.min.js"
            
            case PrismPowershellJs = "/Resource/prism/components/prism-powershell.js"
            
            case PrismPowershellMinJs = "/Resource/prism/components/prism-powershell.min.js"
            
            case PrismProcessingJs = "/Resource/prism/components/prism-processing.js"
            
            case PrismProcessingMinJs = "/Resource/prism/components/prism-processing.min.js"
            
            case PrismPrologJs = "/Resource/prism/components/prism-prolog.js"
            
            case PrismPrologMinJs = "/Resource/prism/components/prism-prolog.min.js"
            
            case PrismPropertiesJs = "/Resource/prism/components/prism-properties.js"
            
            case PrismPropertiesMinJs = "/Resource/prism/components/prism-properties.min.js"
            
            case PrismProtobufJs = "/Resource/prism/components/prism-protobuf.js"
            
            case PrismProtobufMinJs = "/Resource/prism/components/prism-protobuf.min.js"
            
            case PrismPuppetJs = "/Resource/prism/components/prism-puppet.js"
            
            case PrismPuppetMinJs = "/Resource/prism/components/prism-puppet.min.js"
            
            case PrismPureJs = "/Resource/prism/components/prism-pure.js"
            
            case PrismPureMinJs = "/Resource/prism/components/prism-pure.min.js"
            
            case PrismPythonJs = "/Resource/prism/components/prism-python.js"
            
            case PrismPythonMinJs = "/Resource/prism/components/prism-python.min.js"
            
            case PrismQJs = "/Resource/prism/components/prism-q.js"
            
            case PrismQMinJs = "/Resource/prism/components/prism-q.min.js"
            
            case PrismQoreJs = "/Resource/prism/components/prism-qore.js"
            
            case PrismQoreMinJs = "/Resource/prism/components/prism-qore.min.js"
            
            case PrismRJs = "/Resource/prism/components/prism-r.js"
            
            case PrismRMinJs = "/Resource/prism/components/prism-r.min.js"
            
            case PrismRestJs = "/Resource/prism/components/prism-rest.js"
            
            case PrismRestMinJs = "/Resource/prism/components/prism-rest.min.js"
            
            case PrismRipJs = "/Resource/prism/components/prism-rip.js"
            
            case PrismRipMinJs = "/Resource/prism/components/prism-rip.min.js"
            
            case PrismRoboconfJs = "/Resource/prism/components/prism-roboconf.js"
            
            case PrismRoboconfMinJs = "/Resource/prism/components/prism-roboconf.min.js"
            
            case PrismRubyJs = "/Resource/prism/components/prism-ruby.js"
            
            case PrismRubyMinJs = "/Resource/prism/components/prism-ruby.min.js"
            
            case PrismRustJs = "/Resource/prism/components/prism-rust.js"
            
            case PrismRustMinJs = "/Resource/prism/components/prism-rust.min.js"
            
            case PrismSasJs = "/Resource/prism/components/prism-sas.js"
            
            case PrismSasMinJs = "/Resource/prism/components/prism-sas.min.js"
            
            case PrismSassJs = "/Resource/prism/components/prism-sass.js"
            
            case PrismSassMinJs = "/Resource/prism/components/prism-sass.min.js"
            
            case PrismScalaJs = "/Resource/prism/components/prism-scala.js"
            
            case PrismScalaMinJs = "/Resource/prism/components/prism-scala.min.js"
            
            case PrismSchemeJs = "/Resource/prism/components/prism-scheme.js"
            
            case PrismSchemeMinJs = "/Resource/prism/components/prism-scheme.min.js"
            
            case PrismScssJs = "/Resource/prism/components/prism-scss.js"
            
            case PrismScssMinJs = "/Resource/prism/components/prism-scss.min.js"
            
            case PrismSmalltalkJs = "/Resource/prism/components/prism-smalltalk.js"
            
            case PrismSmalltalkMinJs = "/Resource/prism/components/prism-smalltalk.min.js"
            
            case PrismSmartyJs = "/Resource/prism/components/prism-smarty.js"
            
            case PrismSmartyMinJs = "/Resource/prism/components/prism-smarty.min.js"
            
            case PrismSqlJs = "/Resource/prism/components/prism-sql.js"
            
            case PrismSqlMinJs = "/Resource/prism/components/prism-sql.min.js"
            
            case PrismStylusJs = "/Resource/prism/components/prism-stylus.js"
            
            case PrismStylusMinJs = "/Resource/prism/components/prism-stylus.min.js"
            
            case PrismSwiftJs = "/Resource/prism/components/prism-swift.js"
            
            case PrismSwiftMinJs = "/Resource/prism/components/prism-swift.min.js"
            
            case PrismTclJs = "/Resource/prism/components/prism-tcl.js"
            
            case PrismTclMinJs = "/Resource/prism/components/prism-tcl.min.js"
            
            case PrismTextileJs = "/Resource/prism/components/prism-textile.js"
            
            case PrismTextileMinJs = "/Resource/prism/components/prism-textile.min.js"
            
            case PrismTwigJs = "/Resource/prism/components/prism-twig.js"
            
            case PrismTwigMinJs = "/Resource/prism/components/prism-twig.min.js"
            
            case PrismTypescriptJs = "/Resource/prism/components/prism-typescript.js"
            
            case PrismTypescriptMinJs = "/Resource/prism/components/prism-typescript.min.js"
            
            case PrismVerilogJs = "/Resource/prism/components/prism-verilog.js"
            
            case PrismVerilogMinJs = "/Resource/prism/components/prism-verilog.min.js"
            
            case PrismVhdlJs = "/Resource/prism/components/prism-vhdl.js"
            
            case PrismVhdlMinJs = "/Resource/prism/components/prism-vhdl.min.js"
            
            case PrismVimJs = "/Resource/prism/components/prism-vim.js"
            
            case PrismVimMinJs = "/Resource/prism/components/prism-vim.min.js"
            
            case PrismWikiJs = "/Resource/prism/components/prism-wiki.js"
            
            case PrismWikiMinJs = "/Resource/prism/components/prism-wiki.min.js"
            
            case PrismXojoJs = "/Resource/prism/components/prism-xojo.js"
            
            case PrismXojoMinJs = "/Resource/prism/components/prism-xojo.min.js"
            
            case PrismYamlJs = "/Resource/prism/components/prism-yaml.js"
            
            case PrismYamlMinJs = "/Resource/prism/components/prism-yaml.min.js"
        }
        
        public enum Plugins: String, FullPathProvidable {
            
            case IndexHtml = "/Resource/prism/plugins/index.html"
            
            public enum Linenumbers: String, FullPathProvidable {
                
                case IndexHtml = "/Resource/prism/plugins/line-numbers/index.html"
                
                case PrismLineNumbersCss = "/Resource/prism/plugins/line-numbers/prism-line-numbers.css"
                
                case PrismLineNumbersJs = "/Resource/prism/plugins/line-numbers/prism-line-numbers.js"
                
                case PrismLineNumbersMinJs = "/Resource/prism/plugins/line-numbers/prism-line-numbers.min.js"
            }
            
            public enum Showlanguage: String, FullPathProvidable {
                
                case IndexHtml = "/Resource/prism/plugins/show-language/index.html"
                
                case PrismShowLanguageCss = "/Resource/prism/plugins/show-language/prism-show-language.css"
                
                case PrismShowLanguageJs = "/Resource/prism/plugins/show-language/prism-show-language.js"
                
                case PrismShowLanguageMinJs = "/Resource/prism/plugins/show-language/prism-show-language.min.js"
            }
        }
        
        public enum Themes: String, FullPathProvidable {
            
            case PrismCoyCss = "/Resource/prism/themes/prism-coy.css"
            
            case PrismDarkCss = "/Resource/prism/themes/prism-dark.css"
            
            case PrismFunkyCss = "/Resource/prism/themes/prism-funky.css"
            
            case PrismOkaidiaCss = "/Resource/prism/themes/prism-okaidia.css"
            
            case PrismSolarizedlightCss = "/Resource/prism/themes/prism-solarizedlight.css"
            
            case PrismTomorrowCss = "/Resource/prism/themes/prism-tomorrow.css"
            
            case PrismTwilightCss = "/Resource/prism/themes/prism-twilight.css"
            
            case PrismCss = "/Resource/prism/themes/prism.css"
            
            static var keys: [String] = [
                "PrismCoyCss",
                "PrismDarkCss",
                "PrismFunkyCss",
                "PrismOkaidiaCss",
                "PrismSolarizedlightCss",
                "PrismTomorrowCss",
                "PrismTwilightCss",
                "PrismCss",
            ]
        }
    }
    
    public enum Styles: String, FullPathProvidable {
        
        case ClearnessDarkCss = "/Resource/Styles/Clearness Dark.css"
        
        case ClearnessCss = "/Resource/Styles/Clearness.css"
        
        case GithubCss = "/Resource/Styles/GitHub.css"
        
        case Github2Css = "/Resource/Styles/GitHub2.css"
        
        case SolarizedDarkCss = "/Resource/Styles/Solarized (Dark).css"
        
        case SolarizedLightCss = "/Resource/Styles/Solarized (Light).css"
        
        static var keys: [String] = [
            "ClearnessDarkCss",
            "ClearnessCss",
            "GithubCss",
            "Github2Css",
            "SolarizedDarkCss",
            "SolarizedLightCss",
        ]
    }
    
    public enum Templates: String, FullPathProvidable {
        
        case DefaultHandlebars = "/Resource/Templates/Default.handlebars"
    }
    
    public enum Themes: String, FullPathProvidable {
        
        case MouFreshAirPlusStyle = "/Resource/Themes/Mou Fresh Air+.style"
        
        case MouFreshAirStyle = "/Resource/Themes/Mou Fresh Air.style"
        
        case MouNightPlusStyle = "/Resource/Themes/Mou Night+.style"
        
        case MouNightStyle = "/Resource/Themes/Mou Night.style"
        
        case MouPaperPlusStyle = "/Resource/Themes/Mou Paper+.style"
        
        case MouPaperStyle = "/Resource/Themes/Mou Paper.style"
        
        case SolarizedDarkPlusStyle = "/Resource/Themes/Solarized (Dark)+.style"
        
        case SolarizedDarkStyle = "/Resource/Themes/Solarized (Dark).style"
        
        case SolarizedLightPlusStyle = "/Resource/Themes/Solarized (Light)+.style"
        
        case SolarizedLightStyle = "/Resource/Themes/Solarized (Light).style"
        
        case TomorrowBlueStyle = "/Resource/Themes/Tomorrow Blue.style"
        
        case TomorrowPlusStyle = "/Resource/Themes/Tomorrow+.style"
        
        case TomorrowStyle = "/Resource/Themes/Tomorrow.style"
        
        case WriterPlusStyle = "/Resource/Themes/Writer+.style"
        
        case WriterStyle = "/Resource/Themes/Writer.style"
        
        static var keys: [String] = [
            "MouFreshAirPlusStyle",
            "MouFreshAirStyle",
            "MouNightPlusStyle",
            "MouNightStyle",
            "MouPaperPlusStyle",
            "MouPaperStyle",
            "SolarizedDarkPlusStyle",
            "SolarizedDarkStyle",
            "SolarizedLightPlusStyle",
            "SolarizedLightStyle",
            "TomorrowBlueStyle",
            "TomorrowPlusStyle",
            "TomorrowStyle",
            "WriterPlusStyle",
            "WriterStyle",
        ]
    }
}
