<?php
 
include("functions.php");

// PHP goes here!
include("db.php");

$sql = "SELECT * FROM mytable";
$result = $conn->query($sql);

?>
<?php
// Check if a delete request has been made
    if (isset($_GET['delete_id'])) {
        $delete_id = $_GET['delete_id'];
        $stmt = $conn->prepare("DELETE FROM mytable WHERE id = ?");
        $stmt->bind_param("i", $delete_id);

    if ($stmt->execute()) {
    // Redirect back to index.php after deletion
    header("Location: index.php");
    exit();
    } else {
    echo "Error deleting record: ". $stmt->error;
    }

    $stmt->close();
    }
?>




    <!-- Header section  -->
<?php include("header.php") ?>

    <!-- Main section  -->
    <div class="container">
        <a href="create.php" class="btn btn-primary mb-6" type="button">Create Record</a>
        
        <table class="table table-bordered">
            <thead>
               <tr>
                    <td>No</td>
                    <td>TItle</td>
                    <td>Description</td>
                    <td>Action</td>
               </tr>
            </thead>
            <tbody>
                <?php 
                    if ($result->num_rows > 0) {
                        // output data of each row
                        $i = 1;
                        while($row = $result->fetch_assoc()) {
                            echo "<tr>";
                            echo "<td>".$i."</td>";
                            echo "<td>".$row["title"]."</td>";
                            echo "<td>".$row["description"]."</td>";
                            echo "<td><a href='edit.php?id=".$row["id"]."' class='btn btn-primary'>Edit</a>
                            <a href='#' onclick='confirmDelete(".$row["id"].")' class='btn btn-danger'>Delete</a></td>";
                            echo "</tr>";
                            $i++;
                        }
                    } else {
                        echo "<tr>";
                        echo "<td colspan='4' style='text-align:center'>No record</td>";
                        echo "</tr>";
                    }
                ?>
            </tbody>
        </table>
    </div>

    <!-- Footer section  -->
<?php include("footer.php") ?>
<script>
function confirmDelete(id) {
if (confirm("Do you really want to delete this record?")) {
        window. location. href = 'index. php?delete_id=' + id;
    }
}
</script>