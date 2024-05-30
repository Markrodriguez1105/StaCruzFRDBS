<?php
include 'ConnectDB.php';
header('Content-Type: application/json');

if (isset($_SERVER['HTTP_ORIGIN'])) {
    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
    header('Access-Control-Allow-Credentials: true');
    header('Access-Control-Max-Age: 86400');
}

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
        header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
        header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");
    exit(0);
}
$document = json_decode(file_get_contents("php://input"));
if ($document) {
    if ($document->action == 'insert') {
        $stmt = $conn->prepare("INSERT INTO `log` (`dvNo`, `chequeNo`, `chequeDate`, `accountCode`, `gross`, `D1`, `D2`, `D3`, `D5`, `DPhil`, `DPag`, `payeeName`, `reason`, `archive`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);");
        // Bind parameters
        $stmt->bind_param(
            "ssssssssssssss",
            $document->dvNo,
            $document->chequeNo,
            $document->chequeDate,
            $document->accountCode,
            $document->gross,
            $document->D1,
            $document->D2,
            $document->D3,
            $document->D5,
            $document->DPhil,
            $document->DPag,
            $document->payeeName,
            $document->reason,
            $document->archive
        );

        if ($stmt->execute()) {
            echo 'Success';
        } else {
            echo 'Failed';
        }

        $stmt->close();
    }
    if ($document->action == 'update') {
        // Prepare the update statement
        $stmt = $conn->prepare("UPDATE `log` SET `chequeNo` = ?, `chequeDate` = ?, `accountCode` = ?, `gross` = ?, `D1` = ?, `D2` = ?, `D3` = ?, `D5` = ?, `DPhil` = ?, `DPag` = ?, `payeeName` = ?, `reason` = ?, `archive` = ? WHERE `log_id` = ?;");

        // Bind parameters
        $stmt->bind_param(
            "sssssssssssssi",
            $document->chequeNo,
            $document->chequeDate,
            $document->accountCode,
            $document->gross,
            $document->D1,
            $document->D2,
            $document->D3,
            $document->D5,
            $document->DPhil,
            $document->DPag,
            $document->payeeName,
            $document->reason,
            $document->archive,
            $document->log_id
        );

        // Execute the statement
        if ($stmt->execute()) {
            echo 'Success';
        } else {
            echo 'Failed';
        }

        $stmt->close();
    }

    if ($document->action == 'delete') {
        $sql = "DELETE FROM `log` WHERE log_id = ?;";

        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $document->log_id);

        if ($stmt->execute()) {
            echo 'Success';
        } else {
            echo 'Failed';
        }
        $stmt->close();
    }

    if ($document->action == 'fetch') {
        $result = $conn->query("SELECT * FROM log;");
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $row['archive'] = convertBoolean($row['archive']);
                $items[] = $row;
            }
        }
        $response = $items;
        echo json_encode($response);
        $result->close();
    }

    if ($document->action == 'archive') {
        $stmt = $conn->prepare("UPDATE `log` SET `archive`= ? WHERE log_id = ?;");
        $stmt->bind_param("ss", $document->archive, $document->log_id);
        if ($stmt->execute()) {
            echo 'Success';
        } else {
            echo 'Failed';
        }
    }

    if ($document->action == 'generateDvNo') {
        $stmt = $conn->execute_query("SELECT CONCAT(YEAR(LOCALTIME),'-', MONTH(prepDate),'-', COUNT(*)) FROM log WHERE YEAR(prepDate) = YEAR(LOCALTIME) && MONTH(prepDate) = MONTH(LOCALTIME);");
        if ($stmt->num_rows >= 0) {
            $response = $stmt->fetch_column(0);
            echo json_encode($response);
        }
        $stmt->close();
    }

    if ($document->action == 'login') {
        $stmt = $conn->prepare("SELECT * FROM `admin` WHERE adminUsername = ? && adminPass = ?");
        $stmt->bind_param("ss", $document->user, $document->pass);

        if ($stmt->execute()) {
            $result = $stmt->get_result();
            $response = $result->fetch_all(MYSQLI_ASSOC);
            if($response){
                echo json_encode(true);
            }else{
                echo json_encode(false);
            }
        } else {
            echo json_encode(["error" => "Failed to execute statement"]);
        }

        $stmt->close();
    }

    $conn->close();
}
function convertBoolean($value)
{
    return $value == '0' ? false : true;
}
