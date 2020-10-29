<?php
/**
 * Created by PhpStorm.
 * User: uzer
 * Author: Rafael Borges
 * Date: 02/08/17
 * Time: 10:44
 * Changes: classe usada para corrigir cabeçalho do request quando gerar pdf na nova estrutura do projeto
 * gerada para pasta site
 */

namespace App;
use mPDF;

class PrintPdf extends mPDF
{
    public function Output($name = '', $dest = '')
    {
        //Output PDF to some destination
        if ($this->showStats) {
            echo '<div>Generated in ' . sprintf('%.2F', (microtime(true) - $this->time0)) . ' seconds</div>';
        }
        //Finish document if necessary
        if ($this->progressBar) {
            $this->UpdateProgressBar(1, '100', 'Finished');
        } // *PROGRESS-BAR*
        if ($this->state < 3)
            $this->Close();
        if ($this->progressBar) {
            $this->UpdateProgressBar(2, '100', 'Finished');
        } // *PROGRESS-BAR*
        // fn. error_get_last is only in PHP>=5.2
        if ($this->debug && function_exists('error_get_last') && error_get_last()) {
            $e = error_get_last();
            if (($e['type'] < 2048 && $e['type'] != 8) || (intval($e['type']) & intval(ini_get("error_reporting")))) {
                echo "<p>Error message detected - PDF file generation aborted.</p>";
                echo $e['message'] . '<br />';
                echo 'File: ' . $e['file'] . '<br />';
                echo 'Line: ' . $e['line'] . '<br />';
                exit;
            }
        }


        if (($this->PDFA || $this->PDFX) && $this->encrypted) {
            throw new MpdfException("PDFA1-b or PDFX/1-a does not permit encryption of documents.");
        }
        if (count($this->PDFAXwarnings) && (($this->PDFA && !$this->PDFAauto) || ($this->PDFX && !$this->PDFXauto))) {
            if ($this->PDFA) {
                echo '<div>WARNING - This file could not be generated as it stands as a PDFA1-b compliant file.</div>';
                echo '<div>These issues can be automatically fixed by mPDF using <i>$mpdf-&gt;PDFAauto=true;</i></div>';
                echo '<div>Action that mPDF will take to automatically force PDFA1-b compliance are shown in brackets.</div>';
            } else {
                echo '<div>WARNING - This file could not be generated as it stands as a PDFX/1-a compliant file.</div>';
                echo '<div>These issues can be automatically fixed by mPDF using <i>$mpdf-&gt;PDFXauto=true;</i></div>';
                echo '<div>Action that mPDF will take to automatically force PDFX/1-a compliance are shown in brackets.</div>';
            }
            echo '<div>Warning(s) generated:</div><ul>';
            $this->PDFAXwarnings = array_unique($this->PDFAXwarnings);
            foreach ($this->PDFAXwarnings AS $w) {
                echo '<li>' . $w . '</li>';
            }
            echo '</ul>';
            exit;
        }

        if ($this->showStats) {
            echo '<div>Compiled in ' . sprintf('%.2F', (microtime(true) - $this->time0)) . ' seconds (total)</div>';
            echo '<div>Peak Memory usage ' . number_format((memory_get_peak_usage(true) / (1024 * 1024)), 2) . ' MB</div>';
            echo '<div>PDF file size ' . number_format((strlen($this->buffer) / 1024)) . ' kB</div>';
            echo '<div>Number of fonts ' . count($this->fonts) . '</div>';
            exit;
        }


        if (is_bool($dest))
            $dest = $dest ? 'D' : 'F';
        $dest = strtoupper($dest);
        if ($dest == '') {
            if ($name == '') {
                $name = 'mpdf.pdf';
                $dest = 'I';
            } else {
                $dest = 'F';
            }
        }

        /* -- PROGRESS-BAR -- */
        if ($this->progressBar && ($dest == 'D' || $dest == 'I')) {
            if ($name == '') {
                $name = 'mpdf.pdf';
            }
            $tempfile = '_tempPDF' . uniqid(rand(1, 100000), true);
            //Save to local file
            $f = fopen(_MPDF_TEMP_PATH . $tempfile . '.pdf', 'wb');
            if (!$f)
                throw new MpdfException('Unable to create temporary output file: ' . $tempfile . '.pdf');
            fwrite($f, $this->buffer, strlen($this->buffer));
            fclose($f);
            $this->UpdateProgressBar(3, '', 'Finished');

            echo '<script type="text/javascript">

		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", "' . _MPDF_URI . 'includes/out.php");

		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "filename");
		hiddenField.setAttribute("value", "' . $tempfile . '");
		form.appendChild(hiddenField);

		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "dest");
		hiddenField.setAttribute("value", "' . $dest . '");
		form.appendChild(hiddenField);

		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "opname");
		hiddenField.setAttribute("value", "' . $name . '");
		form.appendChild(hiddenField);

		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "path");
		hiddenField.setAttribute("value", "' . urlencode(_MPDF_TEMP_PATH) . '");
		form.appendChild(hiddenField);

		document.body.appendChild(form);
		form.submit();

		</script>
		</div>
		</body>
		</html>';
            exit;
        }
        else {
            if ($this->progressBar) {
                $this->UpdateProgressBar(3, '', 'Finished');
            }
            /* -- END PROGRESS-BAR -- */

            switch ($dest) {
                case 'I':
                    if ($this->debug && !$this->allow_output_buffering && ob_get_contents()) {
                        echo "<p>Output has already been sent from the script - PDF file generation aborted.</p>";
                        exit;
                    }
                    //Send to standard output
                    if (PHP_SAPI != 'cli') {
                        //We send to a browser

                        header('Content-Type: application/pdf');
                        header('Access-Control-Allow-Origin: *');
                        if (headers_sent())
                            throw new MpdfException('Some data has already been output to browser, can\'t send PDF file');
                        if (!isset($_SERVER['HTTP_ACCEPT_ENCODING']) OR empty($_SERVER['HTTP_ACCEPT_ENCODING'])) {
                            // don't use length if server using compression
                            header('Content-Length: ' . strlen($this->buffer));
                        }
                        header('Content-disposition: inline; filename="' . $name . '"');
                        header('Cache-Control: public, must-revalidate, max-age=0');
                        header('Pragma: public');
                        header('Expires: Sat, 26 Jul 1997 05:00:00 GMT');
                        header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT');
                    }
                    echo $this->buffer;
                    break;
                case 'D':
                    //Download file
                    header('Content-Description: File Transfer');
                    if (headers_sent())
                        throw new MpdfException('Some data has already been output to browser, can\'t send PDF file');
                    header('Content-Transfer-Encoding: binary');
                    header('Cache-Control: public, must-revalidate, max-age=0');
                    header('Pragma: public');
                    header('Expires: Sat, 26 Jul 1997 05:00:00 GMT');
                    header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT');
                    header('Content-Type: application/force-download');
                    header('Content-Type: application/octet-stream', false);
                    header('Content-Type: application/download', false);
                    header('Content-Type: application/pdf', false);
                    if (!isset($_SERVER['HTTP_ACCEPT_ENCODING']) OR empty($_SERVER['HTTP_ACCEPT_ENCODING'])) {
                        // don't use length if server using compression
                        header('Content-Length: ' . strlen($this->buffer));
                    }
                    header('Content-disposition: attachment; filename="' . $name . '"');
                    echo $this->buffer;
                    break;
                case 'F':
                    //Save to local file
                    $f = fopen($name, 'wb');
                    if (!$f)
                        throw new MpdfException('Unable to create output file: ' . $name);
                    fwrite($f, $this->buffer, strlen($this->buffer));
                    fclose($f);
                    break;
                case 'S':
                    //Return as a string
                    return $this->buffer;
                default:
                    throw new MpdfException('Incorrect output destination: ' . $dest);
            }
        } // *PROGRESS-BAR*
        //======================================================================================================
        // DELETE OLD TMP FILES - Housekeeping
        // Delete any files in tmp/ directory that are >1 hrs old
        $interval = 3600;
        if ($handle = @opendir(preg_replace('/\/$/', '', _MPDF_TEMP_PATH))) { // mPDF 5.7.3
            while (false !== ($file = readdir($handle))) {
                if (($file != "..") && ($file != ".") && !is_dir(_MPDF_TEMP_PATH . $file) && ((filemtime(_MPDF_TEMP_PATH . $file) + $interval) < time()) && (substr($file, 0, 1) !== '.') && ($file != 'dummy.txt')) { // mPDF 5.7.3
                    unlink(_MPDF_TEMP_PATH . $file);
                }
            }
            closedir($handle);
        }
        //==============================================================================================================

        return '';
    }
}